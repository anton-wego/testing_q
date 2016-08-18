require 'rails_helper'

RSpec.describe ManageController, type: :controller do
  before(:each) do
    FactoryGirl.create(:quiz)
  end
  describe "GET index" do
    it "has a 200 status code" do
      get :index
      expect(response.status).to eq(200)
    end

    it "has 1 quiz" do
      get :index
      expect(assigns(:quizes).size).to eq(1)
    end
  end

  describe "GET new" do
    it "has a 200 status code" do
      get :new
      expect(response.status).to eq(200)
    end

    it "has variable quiz and the value is object of Quiz" do
      get :new

      assigns(:quiz) == nil
      assigns(:quiz) == Quiz.new
    end
  end

  describe "POST create" do
    it "save one quiz and valid" do
      post :create, params: {quiz: {question: 'test qeustion?', answer: '10'}}

      expect(assigns(:quiz).answer).to eq('10')
      expect(flash.notice).to eq("Your quiz has been saved")
      response == redirect_to(manage_index_url)
    end

    it "try save one quiz and not valid" do
      post :create, params: {quiz: {question: 'test qeustion?'}}

      expect(assigns(:quiz).new_record?).to eq(true)
      expect(flash.alert).to eq("Your quiz can't be saved")
      response == render_template(:new)
    end
  end

  describe "GET edit" do
    it "has a 200 status code" do
      id = Quiz.first.id
      get :edit, params: {id: id}
      expect(response.status).to eq(200)
    end

    it "has variable quiz and record found" do
      id = Quiz.first.id
      get :edit, params: {id: id}

      expect(assigns(:quiz).id).to eq(id)
    end

    it "has variable quiz and record not found" do
      get :edit, params: {id: 100000000}

      expect(flash.alert).to eq("Your quiz can't be found")
      response == redirect_to(manage_index_url)
    end
  end

  describe "PUT update" do
    it "update one quiz and valid" do
      id = Quiz.last.id
      put :update, params: {id: id, quiz: {question: 'test qeustion?', answer: '90'}}
      expect(assigns(:quiz).answer).to eq('90')
      expect(flash.notice).to eq("Your quiz has been saved")
      response == redirect_to(manage_index_url)
    end

    it "try update one quiz and not valid" do
      id = Quiz.last.id
      put :update, params: {id: id, quiz: {question: 'test qeustion?', answer: ''}}

      expect(flash.alert).to eq("Your quiz can't be saved")
      response == render_template(:edit)
    end
  end

  describe "DELETE destroy" do
    it "delete one quiz and valid" do
      id = Quiz.last.id
      delete :destroy, params: {id: id}
      expect(assigns(:quiz).id).to eq(id)
      expect(flash.notice).to eq("Your quiz has been deleted")
      response == redirect_to(manage_index_url)
    end

    it "try delete one quiz and not valid" do
      delete :destroy, params: {id: 100000000}
      response == render_template(:edit)
    end
  end
end
