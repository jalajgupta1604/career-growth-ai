class AutoModerationService
  BLOCKED_KEYWORDS = %w[
    spam scam phishing hack exploit malware virus trojan
    nigger faggot retard kys kill yourself
  ].freeze

  WARNING_KEYWORDS = %w[
    prostitution drugs gambling betting casino lottery
    crypto investment guaranteed profit scheme
    telegram whatsapp contact dm
  ].freeze

  SPAM_PATTERNS = [
    /(.)\1{5,}/,                          # Repeated characters (aaaaaaa)
    /https?:\/\/\S+/i,                    # URLs
    /(?:\+?\d[\d\s-]{8,})/,              # Phone numbers
    /\b(?:earn|make|win)\s+\$?\d+/i,     # Earn money spam
    /(?:click|visit|check)\s+(?:here|this|link)/i, # Click bait
  ].freeze

  def initialize(content, user: nil)
    @content = content.to_s.downcase.strip
    @user = user
    @flags = []
  end

  def moderate
    check_blocked_keywords
    check_warning_keywords
    check_spam_patterns
    check_user_trust

    {
      status: determine_status,
      flagged_keywords: @flags.uniq,
      auto_moderated: @flags.any?
    }
  end

  def self.moderate_post(post)
    result = new(
      "#{post.title} #{post.content}",
      user: post.user
    ).moderate

    post.update!(
      moderation_status: result[:status],
      flagged_keywords: result[:flagged_keywords],
      auto_moderated_at: result[:auto_moderated] ? Time.current : nil
    )

    if result[:status] == "rejected"
      ContentFlag.create!(
        user: post.user,
        flaggable: post,
        reason: "Auto-moderation: #{result[:flagged_keywords].join(', ')}",
        status: :pending
      )
    end

    result[:status]
  end

  private

  def check_blocked_keywords
    BLOCKED_KEYWORDS.each do |keyword|
      @flags << "blocked:#{keyword}" if @content.include?(keyword)
    end
  end

  def check_warning_keywords
    WARNING_KEYWORDS.each do |keyword|
      @flags << "warning:#{keyword}" if @content.include?(keyword)
    end
  end

  def check_spam_patterns
    SPAM_PATTERNS.each_with_index do |pattern, idx|
      @flags << "spam_pattern:#{idx}" if @content.match?(pattern)
    end
  end

  def check_user_trust
    return unless @user

    if @user.trust_score < 20
      @flags << "low_trust_user"
    end

    if @user.flags_received_count > 5
      @flags << "frequently_flagged_user"
    end
  end

  def determine_status
    blocked = @flags.any? { |f| f.start_with?("blocked:") }
    return "rejected" if blocked

    warning_count = @flags.count { |f| f.start_with?("warning:", "spam_pattern:", "low_trust", "frequently_flagged") }
    return "pending_review" if warning_count >= 2
    return "pending_review" if @flags.any? { |f| f.start_with?("low_trust", "frequently_flagged") }

    "approved"
  end
end
