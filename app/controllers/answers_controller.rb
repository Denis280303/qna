class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: [:new, :create]
  before_action :load_answer, only: [:show, :destroy, :update]

  def show; end

  def new
    @answer = Answer.new
  end

  def create
    @answer = @question.answers.new(answer_params.merge(user: current_user))
    @answer.save
  end

  def destroy
    if current_user.author?(@answer)
      flash[:notice] = 'Your answer has been successfully deleted!' if @answer.destroy
    else
      flash[:notice] = 'You are not able to delete this answer!'
    end
    redirect_to @answer.question
  end

  def update
    @answer.update(answer_params)
    @question = @answer.question
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end
end
