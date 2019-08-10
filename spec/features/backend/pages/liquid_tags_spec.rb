# frozen_string_literal: true

require "rails_helper"

RSpec.describe "Backend - Pages (HTML)", type: :feature do
  def fill_in_page_form_with(content)
    fill_in "Title", with: "Amazing"
    fill_in "Slug", with: "amazing"
    fill_in "Content", with: content
  end

  describe "creation with Liquid tags" do
    before { stub_authorization! }

    describe "successful" do
      let(:success_message) { "Page was successfully created." }
      let(:collection_content) do
        %(
          {% collection things = 'my-collection' %}
          {% for item in things %}
            {{ forloop.index }}: {{ item.name }}
          {% endfor %}
        )
      end
      let(:collectionfor_content) do
        %(
          {% collectionfor item in 'my-collection' %}
            {{ forloop.index }}: {{ item.name }}
          {% endcollectionfor %}
        )
      end

      it "accepts valid `asset` tag" do
        visit "/backend/pages/new"

        fill_in_page_form_with("{% asset 'amazing.jpg' %}")
        click_button "Create Page"

        expect(page).to have_content(success_message)
      end

      it "accepts valid `collection` tag" do
        visit "/backend/pages/new"

        fill_in_page_form_with(collection_content)
        click_button "Create Page"

        expect(page).to have_content(success_message)
      end

      it "accepts valid `collectionfor` tag" do
        visit "/backend/pages/new"

        fill_in_page_form_with(collectionfor_content)
        click_button "Create Page"

        expect(page).to have_content(success_message)
      end

      it "accepts valid `gist` tag" do
        visit "/backend/pages/new"

        fill_in_page_form_with("{% gist '0d6f8a168a225fda62e8d2ddfe173271' %}")
        click_button "Create Page"

        expect(page).to have_content(success_message)
      end

      it "accepts valid `noembed` tag" do
        content = "{% noembed 'https://www.youtube.com/watch?v=NOGEyBeoBGM' %}"

        visit "/backend/pages/new"

        fill_in_page_form_with(content)
        click_button "Create Page"

        expect(page).to have_content(success_message)
      end

      it "accepts valid `vimeo` tag" do
        visit "/backend/pages/new"

        fill_in_page_form_with("{% vimeo '183344978' %}")
        click_button "Create Page"

        expect(page).to have_content(success_message)
      end

      it "accepts valid `widget` tag" do
        visit "/backend/pages/new"

        fill_in_page_form_with("{% youtube 'amazing' %}")
        click_button "Create Page"

        expect(page).to have_content(success_message)
      end

      it "accepts valid `youtube` tag" do
        visit "/backend/pages/new"

        fill_in_page_form_with("{% youtube 'NOGEyBeoBGM' %}")
        click_button "Create Page"

        expect(page).to have_content(success_message)
      end
    end

    describe "unsuccessful" do
      let(:liquid_error) { "Content contains invalid Liquid formatting" }
      let(:collection_content) do
        %(
          {% collection things %}
          {% for item in things %}
            {{ forloop.index }}: {{ item.name }}
          {% endfor %}
        )
      end
      let(:collectionfor_content) do
        %(
          {% collectionfor item %}
            {{ forloop.index }}: {{ item.name }}
          {% endcollectionfor %}
        )
      end

      %w[asset gist noembed vimeo widget youtube].each do |tag|
        it "fails without key for `#{tag}` tag" do
          visit "/backend/pages/new"

          fill_in_page_form_with("{% #{tag} %}")
          click_button "Create Page"

          expect(page.find(".form-group.page_content"))
            .to have_content(liquid_error)
        end
      end

      it "fails without key or slug for `collection` tag" do
        visit "/backend/pages/new"

        fill_in_page_form_with(collection_content)
        click_button "Create Page"

        expect(page.find(".form-group.page_content"))
          .to have_content(liquid_error)
      end

      it "fails without slug for `collectionfor` tag" do
        visit "/backend/pages/new"

        fill_in_page_form_with(collectionfor_content)
        click_button "Create Page"

        expect(page.find(".form-group.page_content"))
          .to have_content(liquid_error)
      end
    end
  end
end
