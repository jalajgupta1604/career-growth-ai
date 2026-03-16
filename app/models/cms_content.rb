class CmsContent < ApplicationRecord
  belongs_to :author, class_name: "User"
  has_many :scheduled_challenges, dependent: :nullify
  has_many :content_versions, dependent: :destroy

  validates :content_type, presence: true, inclusion: { in: %w[lesson company_pack challenge skill_trend banner announcement] }
  validates :title, presence: true
  validates :slug, uniqueness: true, allow_blank: true

  before_validation :generate_slug, if: -> { slug.blank? && title.present? }

  scope :published, -> { where(status: "published") }
  scope :drafts, -> { where(status: "draft") }
  scope :by_type, ->(type) { where(content_type: type) }
  scope :ordered, -> { order(position: :asc, created_at: :desc) }
  scope :active_banners, -> { where(content_type: "banner", status: "published").ordered }
  scope :active_announcements, -> { where(content_type: "announcement", status: "published").ordered }

  def create_version!(author:, change_summary: nil)
    next_version = content_versions.maximum(:version_number).to_i + 1
    content_versions.create!(
      author: author,
      version_number: next_version,
      title: title,
      body: body,
      change_summary: change_summary
    )
  end

  def restore_version!(version_number)
    version = content_versions.find_by!(version_number: version_number)
    update!(title: version.title, body: version.body)
  end

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
