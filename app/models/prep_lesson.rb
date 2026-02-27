class PrepLesson < ApplicationRecord
  belongs_to :prep_category
  has_many :lesson_progresses, dependent: :destroy

  validates :title, presence: true

  def status_for(user)
    lesson_progresses.find_by(user_id: user.id)&.status || "not_started"
  end

  def completed_by?(user)
    lesson_progresses.exists?(user_id: user.id, status: :completed)
  end
end
