class CareerCoachService
  def initialize(user)
    @user = user
  end

  def start_conversation(topic: nil)
    conversation = @user.coach_conversations.create!(
      title: topic || "New conversation",
      topic: topic,
      status: "active",
      context_data: build_context
    )

    system_msg = build_system_message
    conversation.coach_messages.create!(role: "system", content: system_msg)

    greeting = generate_greeting(topic)
    conversation.coach_messages.create!(role: "assistant", content: greeting)

    conversation
  end

  def send_message(conversation, content)
    conversation.coach_messages.create!(role: "user", content: content)

    history = conversation.coach_messages.ordered.map { |m| { role: m.role, content: m.content } }
    prompt = build_chat_prompt(history)

    response = GeminiClient.new.generate(prompt)
    response ||= "I'm here to help with your career questions. Could you rephrase that?"

    conversation.coach_messages.create!(role: "assistant", content: response)
    conversation.touch

    response
  end

  def conversations_list
    @user.coach_conversations.recent.limit(20)
  end

  def suggested_topics
    topics = [
      { title: "Salary Negotiation Tips", icon: "currency", description: "How to negotiate your next raise" },
      { title: "Career Switch Strategy", icon: "switch", description: "Planning a role or industry change" },
      { title: "Interview Preparation", icon: "interview", description: "Get ready for your next interview" },
      { title: "Skill Development Plan", icon: "skill", description: "What to learn next for growth" },
      { title: "Resume Review", icon: "resume", description: "Tips to improve your resume" },
      { title: "Work-Life Balance", icon: "balance", description: "Managing career growth and wellbeing" }
    ]

    report = @user.career_reports.order(created_at: :desc).first
    if report && report.salary_gap_percentage.to_f > 10
      topics.unshift({ title: "Close Your Salary Gap", icon: "gap", description: "You're #{report.salary_gap_percentage.round}% below market — let's fix that" })
    end

    topics
  end

  private

  def build_context
    resume = @user.resumes.where(parsing_status: :completed).order(created_at: :desc).first
    report = @user.career_reports.order(created_at: :desc).first

    {
      role: @user.role,
      city: @user.city,
      experience_years: @user.experience_years,
      current_salary: @user.current_salary,
      skills: resume&.parsed_data&.dig("skills")&.first(15) || [],
      salary_gap: report&.salary_gap_percentage,
      interview_score: report&.interview_score
    }
  end

  def build_system_message
    ctx = build_context
    <<~MSG
      You are an AI Career Coach for Indian tech professionals on the Career Growth AI platform.

      User profile:
      - Name: #{@user.full_name}
      - Role: #{ctx[:role]}
      - City: #{ctx[:city]}
      - Experience: #{ctx[:experience_years]} years
      - Current Salary: ₹#{ctx[:current_salary]} per annum
      - Skills: #{ctx[:skills].join(', ')}
      #{ctx[:salary_gap] ? "- Salary Gap: #{ctx[:salary_gap]}% below market" : ""}
      #{ctx[:interview_score] ? "- Interview Readiness: #{ctx[:interview_score]}/100" : ""}

      Guidelines:
      - Be warm, encouraging, and specific to the Indian tech market
      - Give actionable advice, not generic platitudes
      - Reference their actual profile data when relevant
      - Keep responses concise (2-4 paragraphs max)
      - Use INR for salary discussions
      - Suggest next steps at the end of each response
    MSG
  end

  def generate_greeting(topic)
    ctx = build_context
    if topic.present?
      "Hi #{@user.full_name&.split&.first || 'there'}! I'd love to help you with **#{topic}**. Based on your profile as a #{ctx[:role]} with #{ctx[:experience_years]} years of experience in #{ctx[:city]}, I have some tailored advice. What specific aspect would you like to explore?"
    else
      greeting = "Hi #{@user.full_name&.split&.first || 'there'}! I'm your AI Career Coach. "
      if ctx[:salary_gap].to_f > 10
        greeting += "I noticed you're #{ctx[:salary_gap].round}% below market rate — I can help you strategize on closing that gap. "
      end
      greeting += "What would you like to work on today? I can help with salary negotiations, interview prep, skill planning, career transitions, and more."
      greeting
    end
  end

  def build_chat_prompt(history)
    messages = history.map { |m| "#{m[:role].upcase}: #{m[:content]}" }.join("\n\n")
    <<~PROMPT
      #{messages}

      ASSISTANT:
    PROMPT
  end
end
