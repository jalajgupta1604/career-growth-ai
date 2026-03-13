class CmsContent < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_many :scheduled_challenges, dependent: :nullify

  validates :content_type, presence: true, inclusion: { in: %w[lesson company_pack challenge skill_trend] }
  validates :title, presence: true
  validates :slug, uniqueness: true, allow_blank: true

  before_validation :generate_slug, if: -> { slug.blank? && title.present? }

  scope :published, -> { where(status: "published") }
  scope :drafts, -> { where(status: "draft") }
  scope :by_type, ->(type) { where(content_type: type) }
  scope :ordered, -> { order(position: :asc, created_at: :desc) }

  def publish!
    update!(status: "published", published_at: Time.current)
  end

  def archive!
    update!(status: "archived")
  end

  def published?
    status == "published"
  end

  private

  def generate_slug
    self.slug = title.parameterize
    count = CmsContent.where("slug LIKE ?", "#{slug}%").count
    self.slug = "#{slug}-#{count}" if count > 0
  end
end
