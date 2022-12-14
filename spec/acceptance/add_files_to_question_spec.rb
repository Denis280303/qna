require_relative 'acceptance_helper'

feature 'Add files to question', '
  In order to illustrate my question
  As an question`s author
  I`d like to be able to attach files
' do
  given(:user) { create(:user) }

  background do
    sign_in(user)
    visit new_question_path
  end

  scenario 'User adds file when asks question', js: true do
    fill_in 'question_title', with: 'QuestionTitle'
    fill_in 'question_body', with: 'QuestionBody'
    click_on 'add file'
    attach_file 'File', "#{Rails.root}/spec/spec_helper.rb"
    click_on 'Create'

    expect(page).to have_link 'spec_helper.rb'
  end
end
