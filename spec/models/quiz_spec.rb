require 'rails_helper'

RSpec.describe Quiz, type: :model do
  context "validation" do
    it { should validate_presence_of(:question) }
    it { should validate_presence_of(:answer) }
  end

  context "call .get_answer" do
    before(:each) do
      @quiz = FactoryGirl.create(:quiz)
    end

    it "should 'CORRECT' with user_answer = 5" do
      rec = Quiz.get_answer(@quiz.id, '5')
      expect(rec).to eq('CORRECT')
    end

    it "should 'CORRECT' with user_answer = 'five'" do
      rec = Quiz.get_answer(@quiz.id, 'five')
      expect(rec).to eq('CORRECT')
    end

    it "should 'INCORRECT' with user_answer = '6'" do
      rec = Quiz.get_answer(@quiz.id, '6')
      expect(rec).to eq('INCORRECT')
    end

    it "should 'INCORRECT' with user_answer = 'six'" do
      rec = Quiz.get_answer(@quiz.id, 'six')
      expect(rec).to eq('INCORRECT')
    end
  end
end
