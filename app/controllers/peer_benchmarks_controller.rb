class PeerBenchmarksController < ApplicationController
  before_action :authenticate_user!

  def show
    @benchmark = PeerBenchmarkService.new(current_user).latest
  end

  def create
    service = PeerBenchmarkService.new(current_user)
    @benchmark = service.generate

    if @benchmark
      redirect_to peer_benchmark_path, notice: "Peer benchmark generated!"
    else
      redirect_to peer_benchmark_path, alert: "Not enough peers for comparison yet. Invite others to join!"
    end
  rescue => e
    Rails.logger.error("Peer benchmark failed: #{e.message}")
    redirect_to peer_benchmark_path, alert: "Failed to generate benchmark. Please try again."
  end
end
