require_relative 'acceptance_helper'

feature 'Answer editing', %q{
	In order to fix mistake
	As an author of answer
} do
  
  given(:user) { create(:user) }
  given!(:question) { create(:question) }
  given!(:answer) { create(:answer, question: question) }

  scenario 'Non-authenticated user try to edit answer' do
  	visit question_path(question)

  	expect(page).to_not have_link 'Edit'
  end

  scenario 'Authenticated author sees link to Edit' do
    sign_in(answer.user)
    visit question_path(answer.question)
    within '.answers' do
      expect(page).to have_link 'Edit'
    end
  end

  scenario "Authenticated user try to edit other user's answer" do
    sign_in(user)
    visit question_path(question)

    expect(page).to_not have_link 'Edit'
  end

  scenario "Authenticated user try to edit his answer", js: true do
    sign_in(answer.user)
    visit question_path(answer.question)
    click_on 'Edit'
    within '.answers' do
      find("#answer_body-#{answer.id}").fill_in(with: 'edited answer')
    end
    click_on 'Save'

  	expect(page).to_not have_content answer.body
  	expect(page).to have_content 'edited answer'
  end

end