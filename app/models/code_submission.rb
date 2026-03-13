class CodeSubmission < ApplicationRecord
  belongs_to :user

  enum :status, { pending: 0, evaluating: 1, completed: 2, failed: 3 }

  validates :code, :language, presence: true
  validates :language, inclusion: { in: %w[python javascript java cpp] }

  scope :recent, -> { order(created_at: :desc) }

  LANGUAGE_LABELS = {
    "python" => "Python",
    "javascript" => "JavaScript",
    "java" => "Java",
    "cpp" => "C++"
  }.freeze

  def language_label
    LANGUAGE_LABELS[language] || language
  end

  def passed?
    test_results.is_a?(Array) ? test_results.all? { |t| t["passed"] } : false
  end
end
