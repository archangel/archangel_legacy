# frozen_string_literal: true

require "highline/import"

def prompt_for_admin_email
  ENV.fetch("ADMIN_EMAIL") do
    ask("Email address:  ") do |question|
      question.default = "archangel@example.com"
    end
  end
end

def prompt_for_admin_name
  ENV.fetch("ADMIN_NAME") do
    ask("Name:  ") { |question| question.default = "Archangel User" }
  end
end

def prompt_for_admin_username
  ENV.fetch("ADMIN_USERNAME") do
    ask("Username:  ") { |question| question.default = "administrator" }
  end
end

def prompt_for_admin_password
  ENV.fetch("ADMIN_PASWORD") do
    ask("Password:  ") { |question| question.echo = "*" }
  end
end

# Site
Archangel::Site.first_or_create! do |item|
  item.name = "Archangel"
  item.locale = "en"
end

# User
unless Archangel::User.first
  email    = prompt_for_admin_email
  name     = prompt_for_admin_name
  username = prompt_for_admin_username
  password = prompt_for_admin_password

  attributes = {
    email: email,
    username: username,
    name: name,
    password: password,
    password_confirmation: password,
    confirmed_at: Time.current
  }

  Archangel::User.create!(attributes)
end

# Homepage
Archangel::Page.published.find_or_create_by!(homepage: true) do |item|
  item.slug = "homepage-#{Time.now.to_i}"
  item.title = "Welcome to Archangel"
  item.content = "<p>Welcome to your new site.</p>"
  item.published_at = Time.current
end
