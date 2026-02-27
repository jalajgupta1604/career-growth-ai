class PdfGenerationJob < ApplicationJob
  queue_as :default

  def perform(career_report_id)
    report = CareerReport.find(career_report_id)
    PdfGeneratorService.new(report).generate
  rescue => e
    Rails.logger.error("PDF generation failed for report #{career_report_id}: #{e.message}")
  end
end
