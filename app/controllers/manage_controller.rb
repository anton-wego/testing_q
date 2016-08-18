class ManageController < ApplicationController

  def index
    @quizes = Quiz.all
  end

  def create
    @quiz = Quiz.new(quiz_params)
    if @quiz.save
      flash.notice = "Your quiz has been saved"
      redirect_to manage_index_url
    else
      flash.alert = "Your quiz can't be saved"
      render action: :new
    end
  end

  def new
    @quiz = Quiz.new
  end

  def edit
    @quiz = Quiz.where(["id = ?", params[:id]]).first

    if @quiz.blank?

      flash.alert = "Your quiz can't be found"
      redirect_to manage_index_url and return
    end
  end

  def update
    @quiz = Quiz.where(["id = ?", params[:id]]).first
    if @quiz.update_attributes(quiz_params)
      flash.notice = "Your quiz has been saved"
      redirect_to manage_index_url
    else
      flash.alert = "Your quiz can't be saved"
      render action: :edit
    end
  end

  def destroy
    @quiz = Quiz.where(["id = ?", params[:id]]).first
    if @quiz.present?
      flash.notice = "Your quiz has been deleted"
      @quiz.destroy
    end
    redirect_to manage_index_url and return
  end


  protected
  def quiz_params
    params.required(:quiz).permit(:question, :answer)
  end

end
