# frozen_string_literal: true

require "rake"

RSpec.shared_context "rake" do
  let(:rake) { Rake::Application.new }
  let(:task_name) { self.class.description }
  let(:task_path) { "../../lib/tasks/#{task_name.split(":").join("/")}_task" }

  subject { rake[task_name] }

  def loaded_files_excluding_current_rake_file
    $LOADED_FEATURES.reject do |file|
      file == Rails.root.join("#{task_path}.rake").to_s
    end
  end

  before do
    Rake.application = rake
    Rake.application.rake_require(task_path,
                                  [Rails.root.to_s],
                                  loaded_files_excluding_current_rake_file)

    Rake::Task.define_task(:environment)
  end
end
