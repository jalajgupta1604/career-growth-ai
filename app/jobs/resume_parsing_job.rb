class ResumeParsingJob < ApplicationJob
  queue_as :default

  def perform(resume_id)
    resume = Resume.find(resume_id)
    resume.processing!

    parser = ResumeParserService.new(resume)
    parsed_data = parser.parse

    resume.update!(
      parsed_data: parsed_data,
      parsing_status: :completed
    )
  rescue => e
    Rails.logger.error("Resume parsing failed for #{resume_id}: #{e.message}")
    resume&.failed!
  end
end
