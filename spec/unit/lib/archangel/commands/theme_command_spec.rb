# frozen_string_literal: true

require "rails_helper"
require "archangel/commands/theme_command"

module Archangel
  module Commands
    RSpec.describe ThemeCommand do
      describe "#theme" do
        before { allow(STDOUT).to receive(:puts) }

        let(:dummy_path) { "spec/dummy" }

        context "when given an theme name" do
          let(:theme_name) { "example" }
          let(:theme_full_name) { "archangel_#{theme_name}_theme" }
          let(:theme_path) { "#{dummy_path}/#{theme_full_name}" }

          before { before_generation(theme_name) }

          after { after_generation(theme_path) }

          it "writes common directories" do
            %w[
              app bin lib spec
            ].each do |dir|
              expect(glob_directories_in(theme_path)).to include(dir)
            end
          end

          it "writes common files" do
            %w[
              .gitignore .rspec Gemfile MIT-LICENSE Rakefile README.md
            ].each do |file|
              expect(glob_files_in(theme_path)).to include(file)
            end
          end

          it "writes gemspec file" do
            expect(glob_files_in(theme_path))
              .to include("#{theme_full_name}.gemspec")
          end
        end

        context "when not given an theme name" do
          let(:theme_name) { nil }
          let(:theme_full_name) { "archangel_sample_theme" }
          let(:theme_path) { "#{dummy_path}/#{theme_full_name}" }

          before { before_generation(theme_name) }

          after { after_generation(theme_path) }

          it "writes common files for `sample`" do
            expect(glob_files_in(theme_path))
              .to include("#{theme_full_name}.gemspec")
          end
        end
      end

      def before_generation(theme_name)
        silence_output

        Dir.chdir("spec/dummy") do
          subject = described_class.new([theme_name])
          subject.invoke_all
        end
      end

      def after_generation(theme_path)
        enable_output

        FileUtils.rm_rf("#{theme_path}/")
      end

      def glob_directories_in(theme_path)
        Dir.glob("#{theme_path}/*")
           .reject { |file| File.file?(file) }
           .map { |file| File.basename(file) }
      end

      def glob_files_in(theme_path)
        Dir.glob("#{theme_path}/{.[^\.]*,*}")
           .select { |file| File.file?(file) }
           .map { |file| File.basename(file) }
      end

      def silence_output
        @orig_stderr = $stderr
        @orig_stdout = $stdout

        $stderr = File.new("/dev/null", "w")
        $stdout = File.new("/dev/null", "w")
      end

      def enable_output
        $stderr = @orig_stderr
        $stdout = @orig_stdout

        @orig_stderr = nil
        @orig_stdout = nil
      end
    end
  end
end
