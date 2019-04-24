# frozen_string_literal: true

json.page do
  json.extract! @page, :id, :title, :homepage, :content

  json.permalink frontend_resource_path(@page)

  json.published_at @page.published_at
end
