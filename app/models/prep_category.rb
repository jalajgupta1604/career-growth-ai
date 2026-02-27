class PrepCategory < ApplicationRecord
  has_many :prep_lessons, -> { order(position: :asc) }, dependent: :destroy

  scope :ordered, -> { order(position: :asc) }

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true

  def completed_count_for(user)
    prep_lessons.joins(:lesson_progresses)
                .where(lesson_progresses: { user_id: user.id, status: :completed })
                .count
  end

  def progress_percentage_for(user)
    total = prep_lessons.count
    return 0 if total.zero?
    (completed_count_for(user).to_f / total * 100).round
  end
end
