require 'rails_helper'

describe AnswersController, type: :controller, aggregate_failures: true do
  let!(:question) { create(:question) }
  let(:answer) { create(:answer, question: question) }

  describe 'GET #show' do
    sign_in_user
    before { get :show, params: { id: answer } }

    it 'renders the show view' do
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    sign_in_user
    before { get :new, params: { question_id: question } }

    it 'renders the new view' do
      expect(response).to render_template :new
    end
  end

  describe 'POST #create' do
    sign_in_user
    context 'with valid attributes' do
      it 'saves a new answer to the database' do
        expect { post :create, params: { answer: attributes_for(:answer), question_id: question, format: :js } }
          .to change(question.answers, :count)
                .by(1)
      end

      it 'render template create' do
        post :create, params: { answer: attributes_for(:answer), question_id: question, format: :js }

        expect(response).to render_template :create
      end
    end

    context 'with invalid attributes' do
      it 'does not save the answer' do
        expect {
 post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question, format: :js } }
          .not_to change(question.answers, :count)
      end

      it 're-renders the new view' do
        post :create, params: { answer: attributes_for(:answer, :invalid), question_id: question, format: :js }

        expect(response).to render_template :create
      end
    end
  end

  describe 'PATCH #update' do
    sign_in_user
    it 'assings the requested answer to @answer' do
      patch :update, params: { id: answer, question_id: question, answer: attributes_for(:answer), format: :js }
      expect(assigns(:answer)).to eq answer
    end

    it 'assigns th question' do
      patch :update, params: { id: answer, question_id: question, answer: attributes_for(:answer), format: :js }
      expect(assigns(:question)).to eq question
    end

    it 'changes answer attributes' do
      patch :update, params: { id: answer, question_id: question, answer: { body: 'new body' }, format: :js }
      answer.reload
      expect(answer.body).to eq 'new body'
    end

    it 'render update template' do
      patch :update, params: { id: answer, question_id: question, answer: attributes_for(:answer), format: :js }
      expect(response).to render_template :update
    end
  end
end
