class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_question, only: [:show, :destroy]

  def index
    @questions = Question.all
  end

  def show
    @answer = Answer.new(question: @question)
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user = current_user
    if @question.save
      redirect_to question_path(@question)
      flash[:notice] = 'Your question successfully created.'
    else
      render :new
    end
  end

  def destroy
    if current_user.author?(@question)
      flash[:notice] = 'Your question has been successfully deleted!' if @question.destroy
    else
      flash[:notice] = 'You are not able to delete this question!'
    end

    redirect_to questions_path
  end

  private

  def question_params
    params.require(:question).permit(:title, :body)
  end

  def load_question
    @question = Question.find(params[:id])
  end
end
