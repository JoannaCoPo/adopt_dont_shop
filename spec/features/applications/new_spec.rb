require 'rails_helper'

RSpec.describe 'the application new' do
  it "can create a new application" do

    visit '/applications/new'

    fill_in('Name', with: 'Bob Bishop')
    fill_in('Address', with: '1234 Adopt St')
    fill_in('City', with: 'Denver')
    fill_in('State', with: 'CO')
    fill_in(:zip, with: 80220)
    click_button('SUBMIT')

    new_application_id = Application.last
    expect(current_path).to eq("/applications/#{new_application_id.id}")
    expect(page).to have_content('Bob Bishop')
  end

  it 'redirects back to the new application page if any fields in form are incomplete ' do
    visit '/applications/new'

    fill_in('Name', with: 'Bob Bishop')
    # fill_in('Address', with: '1234 Adopt St') #won't fill this in
    fill_in('City', with: 'Denver')
    fill_in('State', with: 'CO')
    fill_in(:zip, with: 80220)
    click_button('SUBMIT')

    expect(current_path).to eq('/applications/new')
    expect(page).to have_content('Pet Adoption Application Form:')

  end
end

# Starting an Application, Form not Completed
#
# As a visitor
# When I visit the new application page
# And I fail to fill in any of the form fields
# And I click submit
# Then I am taken back to the new applications page
# And I see a message that I must fill in those fields.
