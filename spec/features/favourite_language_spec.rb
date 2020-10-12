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
end
