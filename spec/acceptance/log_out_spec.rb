require 'rails_helper'

feature 'Log out', '
  In order to be able log out
  As an user
  I want be able to log out
 ' do
  given(:user) { create(:user) }

  scenario 'Existing user try to log out' do
    sign_in(user)
    visit root_path
    click_on 'Sign out'

    expect(page).to have_content 'Signed out successfully.'
  end

  scenario 'The unregistered user tries to log out' do
    visit root_path

    expect(page).to_not have_content 'Sign Out'
  end
end
