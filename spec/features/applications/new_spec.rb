require 'rails_helper'

RSpec.describe 'the application new' do
  it "can create a new application" do

    visit '/applications/new'

    fill_in('Name', with: 'Winston Bishop')
    fill_in('Address', with: '1234 Adopt St')
    fill_in('City', with: 'Denver')
    fill_in('State', with: 'CO')
    fill_in('Zip Code', with: 80220)
    click_button('Submit')
save_and_open_page
    new_application_id = Application.last
    expect(current_path).to eq("/applications/#{new_application_id.id}")
    expect(page).to have_content('Winston Bishop')
  end
end

# where I see a form
# When I fill in this form with my:
#   - Name
#   - Street Address
#   - City
#   - State
#   - Zip Code
# And I click submit
# Then I am taken to the new application's show page
# And I see my Name, address information, and description of why I would make a good home
# And I see an indicator that this application is "In Progress"
