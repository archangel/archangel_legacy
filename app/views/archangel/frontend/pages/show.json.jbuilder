# frozen_string_literal: true

json.page do
  json.extract! @page, :id, :title, :path, :content, :meta_keywords,
                :meta_description

  json.published_at @page.published_at.strftime("%F %T")
  json.published_at_timestamp @page.published_at.to_time.to_i
end
