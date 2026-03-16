class DunningJob < ApplicationJob
  queue_as :default

  def perform
    DunningService.process_all
  end
end
