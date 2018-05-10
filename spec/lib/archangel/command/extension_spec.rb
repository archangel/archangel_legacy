# frozen_string_literal: true

require "rails_helper"
require "archangel/command/extension"

module Archangel
  module Command
    RSpec.describe Extension do
      describe "#extension" do
        before { allow(STDOUT).to receive(:puts) }

        let(:dummy_path) { "spec/dummy" }

        context "when given an extension name" do
          let(:extension_name) { "example" }
          let(:extension_full_name) { "archangel_#{extension_name}" }
          let(:extension_path) { "#{dummy_path}/#{extension_full_name}" }

          before { before_generation(extension_name) }

          after { after_generation(extension_path) }

          it "should write common directories" do
            %w[app bin config lib spec].each do |dir|
              expect(glob_directories_in(extension_path)).to include(dir)
            end
          end

          it "should write common files" do
            %w[.editorconfig .gitignore .rspec .rubocop.yml Gemfile
               MIT-LICENSE Rakefile README.md].each do |file|
              expect(glob_files_in(extension_path)).to include(file)
            end

            expect(glob_files_in(extension_path))
              .to include("#{extension_full_name}.gemspec")
          end
        end

        context "when not given an extension name" do
          let(:extension_name) { nil }
          let(:extension_full_name) { "archangel_sample" }
          let(:extension_path) { "#{dummy_path}/#{extension_full_name}" }

          before { before_generation(extension_name) }

          after { after_generation(extension_path) }

          it "should write common files for `sample`" do
            expect(glob_files_in(extension_path))
              .to include("#{extension_full_name}.gemspec")
          end
        end
      end

      def before_generation(extension_name)
        silence_output

        Dir.chdir("spec/dummy") do
          subject = described_class.new([extension_name])
          subject.invoke_all
        end
      end

      def after_generation(extension_path)
        enable_output

        FileUtils.rm_rf("#{extension_path}/")
      end

      def glob_directories_in(extension_path)
        Dir.glob("#{extension_path}/*")
           .reject { |file| File.file?(file) }
           .map { |file| File.basename(file) }
      end

      def glob_files_in(extension_path)
        Dir.glob("#{extension_path}/{.[^\.]*,*}")
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
