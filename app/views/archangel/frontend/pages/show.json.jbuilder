# frozen_string_literal: true

json.page do
  json.extract! @page, :id, :title, :homepage

  json.permalink frontend_resource_path(@page)
  json.content @page.content_compiled
  json.published_at @page.published_at
end
