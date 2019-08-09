# frozen_string_literal: true

require "json-schema"

RSpec::Matchers.define :match_response_schema do |schema|
  match do |response|
    schema_directory = "#{Dir.pwd}/spec/fixtures/schemas"
    schema_path = "#{schema_directory}/#{schema}.json"

    JSON::Validator.validate!(schema_path, response.body, strict: true)
  end
end
