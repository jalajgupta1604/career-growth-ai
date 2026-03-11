class MockInterview < ApplicationRecord
  belongs_to :user

  enum :status, { not_started: 0, in_progress: 1, completed: 2 }
  enum :interview_type, { technical: "technical", behavioral: "behavioral", system_design: "system_design", mixed: "mixed" }, prefix: true

  validates :user, presence: true
  validates :difficulty, inclusion: { in: %w[easy medium hard] }

  scope :recent, -> { order(created_at: :desc) }

  def current_question_index
    answered_questions
  end

  def current_question
    questions_data[current_question_index]
  end

  def progress_percentage
    return 0 if total_questions.zero?
    (answered_questions.to_f / total_questions * 100).round
  end

  def finished?
    answered_questions >= total_questions
  end
end
