# frozen_string_literal: true

json.extract! @page, :id, :title, :path, :content, :meta_keywords,
              :meta_description, :published_at
