require 'rails_helper'

feature 'The user can watch all questions', '
  As an authenticated user
  I would like to be able to watch the questions
  User can see each question singly
' do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  describe 'Authenticated user tries to watch all questions' do
    background do
      sign_in(user)
      visit questions_path
    end

    scenario 'all questions' do
      expect(current_path).to eq(questions_path)
    end

    scenario 'question singly' do
      visit questions_path(question)
      click_on 'Show'

      expect(page).to have_content question.body
    end
  end
end
