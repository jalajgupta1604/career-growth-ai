class CompanyPack < ApplicationRecord
  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true

  scope :ordered, -> { order(position: :asc) }

  def question_count
    (questions_data || []).size
  end

  def round_count
    (interview_rounds || []).size
  end
end
