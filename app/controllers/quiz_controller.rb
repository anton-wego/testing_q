class QuizController < ApplicationController

  def show
    @quiz = Quiz.where(["id = ?", params[:id]]).first
  end

  def answer
    render json: {result: Quiz.get_answer(params[:quiz_id], params[:answer])}.to_json
  end
end
