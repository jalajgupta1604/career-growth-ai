module Cacheable
  extend ActiveSupport::Concern

  private

  def cached_count(key, scope, expires_in: 5.minutes)
    Rails.cache.fetch(key, expires_in: expires_in) { scope.count }
  end

  def cached_query(key, expires_in: 5.minutes, &block)
    Rails.cache.fetch(key, expires_in: expires_in, &block)
  end
end
