require 'rails_helper'

RSpec.feature 'Layout', type: :feature do
  scenario 'Page title is present' do
    visit root_path
    expect(page).to have_title('Ultimate Recipe Assistant')
  end

  scenario 'Background overlay is visible' do
    visit root_path
    expect(page).to have_css('.overlay')
  end
end
