# frozen_string_literal: true

Rails.application.config.assets.precompile += [
  "*.gif", "*.ico", "*.jpeg", "*.jpg", "*.png",
  "*.eot", "*.svg", "*.ttf", "*.woff", "*.woff2",
  "auth.css", "auth.js",
  "backend.css", "backend.js",
  "frontend.css", "frontend.js"
]
