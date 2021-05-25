require 'rails_helper'

RSpec.describe 'the application show' do
  xit "shows an application and all its attributes" do
    application = Application.create!(name: 'Winston Bishop', address: '1234 Turing Ave', description: 'I have the time and space', desired_pets:'Ferguson', status: 'Pending', city: 'Portland', state: 'OR', zip: 92377)
    visit "/applications/#{application.id}"

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.address)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.desired_pets)
    expect(page).to have_content(application.status)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip)
  end

  # WILL NEED TO UTILIZE PARTIALS AT SOME POINT
  xit 'displays section to search for a pet to add to application' do
    application = Application.create!(name: 'Winston Bishop', address: '1234 Turing Ave', description: 'I have the time and space', desired_pets:'Ferguson', status: 'Pending', city: 'Portland', state: 'OR', zip: 92377)
    visit "/applications/#{application.id}"

    expect(page).to have_content("Add a Pet to this Application")
    within('section#pet-search') do
      expect(page).to have_button('Search')
    end
  end

  it 'takes user back to show page when the submit button is clicked' do
    application = Application.create!(name: 'Winston Bishop', address: '1234 Turing Ave', description: 'I have the time and space', desired_pets:'Ferguson', status: 'Pending', city: 'Portland', state: 'OR', zip: 92377)
    visit "/applications/#{application.id}"

    click_button('Search')
    expect(current_path).to eq("/applications/:id")
  end
end

# Searching for Pets for an Application
#
# As a visitor
# When I visit an application's show page
# And that application has not been submitted,
# Then I see a section on the page to "Add a Pet to this Application"
# In that section I see an input where I can search for Pets by name
# When I fill in this field with a Pet's name
# And I click submit,
# Then I am taken back to the application show page
# And under the search bar I see any Pet whose name matches my search
