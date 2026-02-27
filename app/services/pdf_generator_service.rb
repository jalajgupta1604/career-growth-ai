class PdfGeneratorService
  def initialize(career_report)
    @report = career_report
    @user = career_report.user
  end

  def generate
    html = render_html
    pdf = WickedPdf.new.pdf_from_string(html, page_size: "A4", margin: { top: 20, bottom: 20, left: 15, right: 15 })

    filename = "career_blueprint_#{@user.full_name&.parameterize || 'report'}_#{Date.today}.pdf"
    @report.file.attach(io: StringIO.new(pdf), filename: filename, content_type: "application/pdf") if @report.respond_to?(:file)

    pdf
  end

  private

  def render_html
    ApplicationController.render(
      template: "career_reports/pdf",
      layout: "pdf",
      assigns: {
        report: @report,
        user: @user,
        salary_data: @report.skill_gap_data,
        roadmap_data: @report.roadmap_data
      }
    )
  end
end
