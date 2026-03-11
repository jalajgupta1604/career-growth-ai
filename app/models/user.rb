class User < ApplicationRecord
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :resumes, dependent: :destroy
  has_many :career_reports, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_many :lesson_progresses, dependent: :destroy
  has_many :mock_interviews, dependent: :destroy
  has_many :negotiation_sessions, dependent: :destroy
  has_many :offer_analyses, dependent: :destroy
  has_many :salary_submissions, dependent: :destroy
  has_many :peer_benchmarks, dependent: :destroy
  has_many :interview_experiences, dependent: :destroy
  has_many :referral_rewards, dependent: :destroy
  has_many :job_recommendations, dependent: :destroy
  has_many :coach_conversations, dependent: :destroy
  has_many :company_members, dependent: :destroy
  has_many :companies, through: :company_members
  has_one  :linkedin_profile, dependent: :destroy
  has_one  :subscription, dependent: :destroy
  has_one_attached :profile_photo

  belongs_to :referrer, class_name: "User", foreign_key: :referred_by_id, optional: true

  validates :email, presence: true, uniqueness: true
  validate :acceptable_profile_photo, if: -> { profile_photo.attached? && profile_photo.new_record? }

  before_create :generate_referral_code

  def self.from_omniauth(auth)
    where(provider: auth.provider, google_uid: auth.uid).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.full_name = auth.info.name
      user.profile_picture_url = auth.info.image
    end
  end

  def onboarding_complete?
    role.present? && city.present? && experience_years.present? && current_salary.present?
  end

  def subscribed?
    legacy_paid? || active_subscription?
  end

  def legacy_paid?
    career_reports.exists?(payment_status: :paid)
  end

  def active_subscription?
    subscription&.active_access? || false
  end

  def avatar_url
    if profile_photo.attached?
      Rails.application.routes.url_helpers.rails_blob_path(profile_photo, only_path: true)
    elsif profile_picture_url.present?
      profile_picture_url
    else
      default_avatar_url
    end
  end

  def default_avatar_url
    initials = (full_name.presence || email.first(1)).to_s.split.map(&:first).join.first(2).upcase
    "https://ui-avatars.com/api/?name=#{CGI.escape(initials)}&background=06b6d4&color=fff&size=128&bold=true"
  end

  def referral_count
    User.where(referred_by_id: id).count
  end

  def referral_url(base_url = "")
    "#{base_url}/?ref=#{referral_code}"
  end

  private

  def generate_referral_code
    self.referral_code ||= "CG#{SecureRandom.alphanumeric(8).upcase}"
  end

  def acceptable_profile_photo
    unless profile_photo.blob.content_type.in?(%w[image/png image/jpeg image/webp])
      errors.add(:profile_photo, "must be PNG, JPEG, or WebP")
    end
    if profile_photo.blob.byte_size > 5.megabytes
      errors.add(:profile_photo, "must be less than 5MB")
    end
  end
end
