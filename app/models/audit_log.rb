class AuditLog < ApplicationRecord
  belongs_to :user

  validates :action, presence: true
  validates :resource_type, presence: true

  scope :recent, -> { order(created_at: :desc) }
  scope :for_resource, ->(type, id) { where(resource_type: type, resource_id: id) }
  scope :by_action, ->(action) { where(action: action) }

  def self.track(user:, action:, resource: nil, metadata: {}, ip_address: nil)
    create!(
      user: user,
      action: action,
      resource_type: resource&.class&.name || "System",
      resource_id: resource&.id,
      metadata: metadata,
      ip_address: ip_address
    )
  end
end
