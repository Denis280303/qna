require 'rails_helper'

feature 'The user can delete the question', '
  In order to clear the history of the questions
  As an authenticated user
  I would like to be able to delete the question
' do
  given(:question) { create(:question) }

  describe 'Authenticated user' do
    given(:user) { create(:user) }

    scenario 'tries to delete the question of the other user' do
      sign_in(user)
      visit questions_path(question)
      click_on 'Delete'

      expect(page).to have_content 'You are not able to delete this question!'
    end

    scenario 'tries to delete his own question' do
      sign_in(question.user)
      visit questions_path(question)

      click_on 'Delete'
      expect(page).to have_content 'Your question has been successfully deleted!'
      expect(current_path).to eq questions_path
      expect(page).to_not have_content question.body
    end
  end
end
