class ResumeParserService
  def initialize(resume)
    @resume = resume
  end

  def parse
    return {} unless @resume.file.attached?

    text = extract_text
    {
      raw_text: text,
      skills: extract_skills(text),
      projects: extract_projects(text),
      certifications: extract_certifications(text),
      experience_entries: extract_experience(text)
    }
  end

  private

  def extract_text
    blob = @resume.file.blob
    case blob.content_type
    when "application/pdf"
      extract_pdf_text(blob)
    when "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
      extract_docx_text(blob)
    else
      ""
    end
  rescue => e
    Rails.logger.error("Resume parsing error: #{e.message}")
    ""
  end

  def extract_pdf_text(blob)
    blob.open do |tempfile|
      reader = PDF::Reader.new(tempfile.path)
      reader.pages.map(&:text).join("\n")
    end
  end

  def extract_docx_text(blob)
    blob.open do |tempfile|
      doc = Docx::Document.open(tempfile.path)
      doc.paragraphs.map(&:text).join("\n")
    end
  end

  def extract_skills(text)
    known_skills = Skill.pluck(:name).map(&:downcase)
    words = text.downcase.scan(/[\w+#.]+/)
    # Also check multi-word skills
    text_lower = text.downcase

    found = known_skills.select do |skill|
      text_lower.include?(skill.downcase)
    end

    found.uniq
  end

  def extract_projects(text)
    sections = text.split(/(?:projects?|portfolio)\s*:?\s*\n/i)
    return [] if sections.length < 2

    project_section = sections[1].split(/\n(?:experience|education|certification|skill)/i).first
    return [] unless project_section

    projects = project_section.strip.split(/\n{2,}/).map(&:strip).reject(&:empty?)
    projects.first(10)
  end

  def extract_certifications(text)
    sections = text.split(/certifications?\s*:?\s*\n/i)
    return [] if sections.length < 2

    cert_section = sections[1].split(/\n(?:experience|education|project|skill)/i).first
    return [] unless cert_section

    cert_section.strip.split(/\n/).map(&:strip).reject(&:empty?).first(10)
  end

  def extract_experience(text)
    sections = text.split(/(?:work\s+)?experience\s*:?\s*\n/i)
    return [] if sections.length < 2

    exp_section = sections[1].split(/\n(?:education|certification|project|skill)/i).first
    return [] unless exp_section

    exp_section.strip.split(/\n{2,}/).map(&:strip).reject(&:empty?).first(10)
  end
end
