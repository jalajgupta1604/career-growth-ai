class CareerReportsController < ApplicationController
  before_action :authenticate_user!

  def create
    @report = CareerReportGeneratorService.new(current_user).generate
    redirect_to career_report_path(@report), notice: "Career report generated!"
  rescue => e
    Rails.logger.error("Report generation failed: #{e.message}")
    redirect_to dashboard_path, alert: "Failed to generate report. Please try again."
  end

  def show
    @report = current_user.career_reports.find(params[:id])
    @salary_data = @report.skill_gap_data&.dig("salary_analysis") || {}
    @skill_data = @report.skill_gap_data&.dig("skill_analysis") || {}
    @roadmap_data = @report.roadmap_data&.dig("roadmap") || {}
    @interview_data = @report.roadmap_data&.dig("interview") || {}
  end

  def preview
    @report = current_user.career_reports.find(params[:id])
    @salary_data = @report.skill_gap_data&.dig("salary_analysis") || {}
  end

  def download_pdf
    @report = current_user.career_reports.find(params[:id])

    unless @report.downloadable?
      redirect_to career_report_path(@report), alert: "Please unlock the full report to download PDF."
      return
    end

    pdf_service = PdfGeneratorService.new(@report)
    pdf_data = pdf_service.generate

    send_data pdf_data,
              filename: "career_blueprint_#{@report.user.full_name&.parameterize || 'report'}_#{Date.today}.pdf",
              type: "application/pdf",
              disposition: "attachment"
  end
end
