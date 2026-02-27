class LessonProgress < ApplicationRecord
  belongs_to :user
  belongs_to :prep_lesson

  enum :status, { not_started: 0, in_progress: 1, completed: 2 }

  validates :user_id, uniqueness: { scope: :prep_lesson_id }
end
