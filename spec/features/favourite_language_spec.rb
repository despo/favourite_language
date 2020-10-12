require 'rails_helper'
RSpec.describe FavouriteLanguage do
  it 'When a user visits the page no errors are displayed' do
    visit root_path

    expect(page).not_to have_content('Username can\'t be blank')
  end

  it 'When searching without specifying a username an error is displayed' do
    visit root_path
    click_on 'Find'

    expect(page).to have_content('Username can\'t be blank')
  end

  context 'when searching with the required parameters' do
    it 'displays the favourite language when the specified username exists' do
      visit root_path
      fill_in 'user[username]', with: 'despo'
      click_on 'Find'

      within('#favourite-language') { expect(page).to have_content('Ruby') }
    end
  end
end
