class AnswersController < ApplicationController
  before_action :authenticate_user!
  before_action :load_question, only: [:new, :create]
  before_action :load_answer, only: %i[show destroy update set_best]
  after_action :publish_answer, only: :create

  include Voted
  include Commented

  def show; end

  def new
    @answer = Answer.new
  end

  def create
    @answer = @question.answers.new(answer_params.merge(user: current_user))
    @answer.save
  end

  def destroy
    @answer.destroy
    render :destroy
  end

  def update
    @answer.update(answer_params)
    @question = @answer.question
  end

  def set_best
    @question = @answer.question
    @answer.mark_best_answer!
  end

  private

  def answer_params
    params.require(:answer).permit(:body, attachments_attributes: [:file])
  end

  def load_question
    @question = Question.find(params[:question_id])
  end

  def load_answer
    @answer = Answer.find(params[:id])
  end

  def publish_answer
    return if @answer.errors.any?

    ActionCable.server.broadcast(
      "answers_for_page_with_question_#{@question.id}", { answer: @answer, question: @question, rating: @answer.rating }
    )
  end
end
