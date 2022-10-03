class QuestionsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_question, only: %i[show destroy update delete_attachment]
  after_action :publish_question, only: :create

  include Voted
  include Commented

  authorize_resource except: :index

  def index
    @questions = Question.all
  end

  def show
    @answer = Answer.new(question: @question)
    @answer.attachments.build
  end

  def new
    @question = Question.new
    @question.attachments.build
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

  def update
    @question.update(question_params)
  end

  def delete_attachment
    @attachment = @question.attachments.find(params[:attach_id])
    @attachment.destroy
    render :delete_attachments
  end

  def delete_attachment_for_answer
    @answer = Answer.find(params[:id])
    @attachment = @answer.attachments.find(params[:attachment_id])
    @attachment.destroy
    render :delete_attachments
  end

  private

  def question_params
    params.require(:question).permit(:title, :body, attachments_attributes: %i[id file _destroy])
  end

  def load_question
    @question = Question.find(params[:id])
  end

  def publish_question
    return if @question.errors.any?

    ApplicationController.renderer.instance_variable_set(
      :@env, {
        'HTTP_HOST' => 'localhost:3000',
        'HTTPS' => 'off',
        'REQUEST_METHOD' => 'GET',
        'SCRIPT_NAME' => '',
        'warden' => warden
      }
    )

    ActionCable.server.broadcast(
      'questions_list',
      ApplicationController.renderer.render(
        partial: 'questions/question',
        locals: {
          question: @question,
          current_user: current_user
        }
      )
    )
  end
end
