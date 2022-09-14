require_relative 'acceptance_helper'

feature 'The user can answer the question', '
  In order to start a discussion about the question
  As an authenticated user
  I would like to be able to answer the question
', js: true do
  given(:user) { create(:user) }
  given(:question) { create(:question) }

  describe 'Authenticated user tries to create the answer' do
    background do
      sign_in(user)
      visit question_path(question)
    end

    scenario 'with valid data' do
      fill_in 'answer_body', with: 'Answer to the question'
      click_on 'Create answer'

      expect(current_path).to eq question_path(question)

      within '.answers' do
        expect(page).to have_content 'Answer to the question'
      end
    end

    scenario 'with invalid data' do
      click_on 'Create answer'

      expect(page).to have_content "Body can't be blank"
    end
  end
end
