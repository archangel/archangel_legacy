# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Archangel Rake task", type: :rake do
  include_context "rake"

  describe "archangel:version" do
    it "find current version" do
      expect { subject.execute }.to match_stdout Archangel::VERSION
    end
  end
end
