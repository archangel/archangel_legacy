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
site = Archangel::Site.first_or_create do |item|
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
    site: site,
    email: email,
    username: username,
    name: name,
    role: "admin",
    password: password,
    password_confirmation: password,
    confirmed_at: Time.current
  }

  Archangel::User.create(attributes)
end

# Homepage
Archangel::Page.published
               .find_or_create_by(site: site, homepage: true) do |item|
  item.slug = "homepage-#{Time.now.to_i}"
  item.title = "Welcome to Archangel"
  item.content = %(
    <p>Welcome to your new site.</p>
  )
  item.published_at = Time.current
end

# Template
page_template = Archangel::Template.find_or_create_by(
  site: site,
  partial: false
) do |item|
  item.name = "Example Page Template"
  item.content = %(
    <p>I think this is the beginning of a beautiful page template.</p>
    {{ content_for_layout }}
    <p>I think this is the end of a beautiful page template.</p>
  )
end

# Page
Archangel::Page.find_or_create_by(
  site: site,
  slug: "example-page",
  template: page_template,
  homepage: false
) do |item|
  item.title = "Example Page"
  item.content = %(
    <p>I think this is the content of the page.</p>
  )
  item.published_at = Time.now
end

# Template
widget_template = Archangel::Template.find_or_create_by(
  site: site,
  partial: true
) do |item|
  item.name = "Example Widget Template"
  item.content = %(
    <p>I think this is the beginning of a beautiful widget template.</p>
    {{ content_for_layout }}
    <p>I think this is the end of a beautiful widget template.</p>
  )
end

# Widget
Archangel::Widget.find_or_create_by(
  site: site,
  slug: "example-widget",
  template: widget_template
) do |item|
  item.name = "Example Widget"
  item.content = %(
    <p>I think this is the content of the widget.</p>
  )
end

# Collection
collection = Archangel::Collection.find_or_create_by(
  site: site,
  slug: "example-collection"
) do |item|
  item.name = "Example Collection"
end

# Fields
Archangel::Field.find_or_create_by(
  collection: collection,
  slug: "field1",
  required: true
) do |item|
  item.label = "Field 1"
  item.classification = "string"
end

# Entry
Archangel::Entry.find_or_create_by(collection: collection) do |item|
  item.value = %({"field1":"Value for field 1"})
  item.available_at = Time.now
end
