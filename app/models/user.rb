class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable, omniauth_providers: [:google_oauth2]

  has_many :resumes, dependent: :destroy
  has_many :career_reports, dependent: :destroy
  has_many :payments, dependent: :destroy

  validates :email, presence: true, uniqueness: true

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
end
