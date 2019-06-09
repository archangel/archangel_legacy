# frozen_string_literal: true

RSpec::Matchers.define :have_meta do |name, expected|
  match do |_actual|
    has_css?("meta[name='#{name}'][content='#{expected}']", visible: false)
  end

  failure_message do |_actual|
    actual = first("meta[name='#{name}']")

    if actual
      "expected that meta #{name} would have content='#{expected}' " \
      "but was '#{actual[:content]}'"
    else
      "expected that meta #{name} would exist with content='#{expected}'"
    end
  end
end
