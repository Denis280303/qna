require_relative 'acceptance_helper'

feature 'Question editing', '
	In order to fix mistake
	As an author of question
' do
  given(:user) { create(:user) }
  given!(:question) { create(:question) }

  scenario 'Non-authenticated user try to edit question' do
    visit questions_path(question)

    expect(page).to_not have_link 'Edit question'
  end

  scenario 'Authenticated author sees link to Edit' do
    sign_in(question.user)
    visit question_path(question)
    within '.questions' do
      expect(page).to have_link 'Edit question'
    end
  end

  scenario "Authenticated user try to edit other user's answer" do
    sign_in(user)
    visit question_path(question)

    expect(page).to_not have_link 'Edit question'
  end

  scenario 'Authenticated user try to edit his answer', js: true do
    sign_in(question.user)
    visit question_path(question)
    click_on 'Edit question'
    within '.questions' do
      find("#question_body-#{question.id}").fill_in(with: 'edited question')
    end
    click_on 'Save'

    expect(page).to_not have_content question.body
    expect(page).to have_content 'edited question'
  end
end
