# frozen_string_literal: true

module ReportsHelper
  def content_with_link(raw_content)
    content =
      raw_content.gsub(Report::TARGET_URI) { "<a href='#{::Regexp.last_match(0)}'>#{::Regexp.last_match(0)}</a>" }
    sanitize(content)
  end
end
