# frozen_string_literal: true

require "rails_helper"

module Archangel
  class FakeApplicationController < ApplicationController; end

  RSpec.describe ApplicationController, type: :controller do
    controller FakeApplicationController do
      include Archangel::ActionableConcern

      def index
        render plain: "index"
      end

      def show
        render plain: "show"
      end

      def new
        render plain: "new"
      end

      def create
        render plain: "create"
      end

      def edit
        render plain: "edit"
      end

      def update
        render plain: "update"
      end

      def destroy
        render plain: "destroy"
      end

      def custom
        render plain: "custom"
      end
    end

    describe "GET #index" do
      it "knows action types" do
        get :index

        expect(subject.action).to eq :index

        expect(subject.collection_action?).to be_truthy
        expect(subject.index_action?).to be_truthy
        expect(subject.show_action?).to be_falsey
        expect(subject.new_action?).to be_falsey
        expect(subject.edit_action?).to be_falsey
        expect(subject.member_action?).to be_falsey
        expect(subject.save_action?).to be_falsey
        expect(subject.restful_action?).to be_truthy
      end
    end

    describe "GET #show" do
      it "knows action types" do
        get :show, params: { id: 1 }

        expect(subject.action).to eq :show

        expect(subject.collection_action?).to be_falsey
        expect(subject.index_action?).to be_falsey
        expect(subject.show_action?).to be_truthy
        expect(subject.new_action?).to be_falsey
        expect(subject.edit_action?).to be_falsey
        expect(subject.member_action?).to be_truthy
        expect(subject.save_action?).to be_falsey
        expect(subject.restful_action?).to be_truthy
      end
    end

    describe "GET #new" do
      it "knows action types" do
        get :new

        expect(subject.action).to eq :new

        expect(subject.collection_action?).to be_falsey
        expect(subject.index_action?).to be_falsey
        expect(subject.show_action?).to be_falsey
        expect(subject.new_action?).to be_truthy
        expect(subject.edit_action?).to be_falsey
        expect(subject.member_action?).to be_falsey
        expect(subject.save_action?).to be_falsey
        expect(subject.restful_action?).to be_truthy
      end
    end

    describe "POST #create" do
      it "knows action types" do
        post :create

        expect(subject.action).to eq :create

        expect(subject.collection_action?).to be_falsey
        expect(subject.index_action?).to be_falsey
        expect(subject.show_action?).to be_falsey
        expect(subject.new_action?).to be_truthy
        expect(subject.edit_action?).to be_falsey
        expect(subject.member_action?).to be_falsey
        expect(subject.save_action?).to be_truthy
        expect(subject.restful_action?).to be_truthy
      end
    end

    describe "GET #edit" do
      it "knows action types" do
        get :edit, params: { id: 1 }

        expect(subject.action).to eq :edit

        expect(subject.collection_action?).to be_falsey
        expect(subject.index_action?).to be_falsey
        expect(subject.show_action?).to be_falsey
        expect(subject.new_action?).to be_falsey
        expect(subject.edit_action?).to be_truthy
        expect(subject.member_action?).to be_truthy
        expect(subject.save_action?).to be_falsey
        expect(subject.restful_action?).to be_truthy
      end
    end

    describe "PUT #update" do
      it "knows action types" do
        put :update, params: { id: 1 }

        expect(subject.action).to eq :update

        expect(subject.collection_action?).to be_falsey
        expect(subject.index_action?).to be_falsey
        expect(subject.show_action?).to be_falsey
        expect(subject.new_action?).to be_falsey
        expect(subject.edit_action?).to be_truthy
        expect(subject.member_action?).to be_truthy
        expect(subject.save_action?).to be_truthy
        expect(subject.restful_action?).to be_truthy
      end
    end

    describe "DELETE #destroy" do
      it "knows action types" do
        delete :destroy, params: { id: 1 }

        expect(subject.action).to eq :destroy

        expect(subject.collection_action?).to be_falsey
        expect(subject.index_action?).to be_falsey
        expect(subject.show_action?).to be_falsey
        expect(subject.new_action?).to be_falsey
        expect(subject.edit_action?).to be_falsey
        expect(subject.member_action?).to be_truthy
        expect(subject.save_action?).to be_truthy
        expect(subject.restful_action?).to be_truthy
      end
    end

    describe "GET #custom" do
      it "knows custom action types" do
        routes.draw { get "custom" => "archangel/fake_application#custom" }

        get :custom

        expect(subject.action).to eq :custom

        expect(subject.collection_action?).to be_falsey
        expect(subject.index_action?).to be_falsey
        expect(subject.show_action?).to be_falsey
        expect(subject.new_action?).to be_falsey
        expect(subject.edit_action?).to be_falsey
        expect(subject.member_action?).to be_falsey
        expect(subject.save_action?).to be_falsey
        expect(subject.restful_action?).to be_falsey
      end
    end
  end
end
