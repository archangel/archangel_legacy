# frozen_string_literal: true

RSpec::Matchers.define :have_title do |expected|
  match do |_actual|
    has_css?("title", text: expected)
  end

  failure_message_for_should do |_actual|
    actual = first("title")

    if actual
      "expected that title would have been '#{expected}' " \
      "but was '#{actual.text}'"
    else
      "expected that title would exist with '#{expected}'"
    end
  end
end
