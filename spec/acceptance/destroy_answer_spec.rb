require_relative 'acceptance_helper'

feature 'The user can delete the answer', '
  In order to clear the history of the answers
  As an authenticated user
  I would like to be able to delete the answer for the question
', js: true do
  given(:answer) { create(:answer) }
  given(:user) { create(:user) }

  describe 'Authenticated user' do
    scenario 'tries to delete the answer of the other user' do
      sign_in(user)
      visit question_path(answer.question)

      expect(page).to_not have_link 'Delete answer'
    end

    scenario 'tries to delete his own answer' do
      sign_in(answer.user)
      visit question_path(answer.question)

      expect(page).to have_content answer.body

      click_on 'Delete answer'

      expect(current_path).to eq(question_path(answer.question))
      expect(page).to_not have_content answer.body
    end
  end
end
