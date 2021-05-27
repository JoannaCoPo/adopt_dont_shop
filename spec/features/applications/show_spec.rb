require 'rails_helper'

RSpec.describe 'the application show' do
  it "shows an application and all its attributes" do
    application = Application.create!(name: 'Winston Bishop', address: '1234 Turing Ave', description: 'I have the time and space', desired_pets:'Ferguson', status: 'Pending', city: 'Portland', state: 'OR', zip: 92377)
    visit "/applications/#{application.id}"

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.address)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.status)
    expect(page).to have_content(application.city)
    expect(page).to have_content(application.state)
    expect(page).to have_content(application.zip)
  end

  # WILL NEED TO UTILIZE PARTIALS AT SOME POINT
  it 'displays section to search for a pet to add to application' do
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
    expect(current_path).to eq("/applications/#{application.id}")
  end

  it 'displays under the search bar any Pet whose name matches the input search' do
    shelter = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    application = Application.create!(name: 'Winston Bishop', address: '1234 Turing Ave', description: 'I have the time and space', desired_pets:'Lobster', status: 'Pending', city: 'Portland', state: 'OR', zip: 92377)
    visit "/applications/#{application.id}"

    fill_in(:search, with: 'Lobster')
    click_button('Search')
    expect(page).to have_link('Lobster')
  end

  it 'can add pet to application via button' do
    shelter = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    application = Application.create!(name: 'Scarlett Cortes', address: '1234 Turing Ave', description: '', desired_pets:'Babe', status: 'In Progress', city: 'Denver', state: 'CO', zip: 80224)
    visit "/applications/#{application.id}"

    fill_in(:search, with: 'Lobster')
    click_button('Search')
    expect(page).to have_button('Adopt this Pet')
    save_and_open_page
    click_button('Adopt this Pet')
    within('p#added-pet') do
      expect(page).to have_content('Lobster')
    end
  end

  xit 'displays input for description in the submission section' do
    shelter = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    # application = Application.create!(name: 'Winston Bishop', address: '1234 Turing Ave', description: '', desired_pets:'Lobster', status: '', city: 'Portland', state: 'OR', zip: 92377)
    application = Application.create!(name: 'Scarlett Cortes', address: '1234 Turing Ave', description: '', desired_pets:'Babe', status: 'In Progress', city: 'Denver', state: 'CO', zip: 80224)
    visit "/applications/#{application.id}"

    fill_in(:search, with: 'Lucille Bald')

    click_button('Search')
    click_button('Adopt this Pet')
    # within('section#submission') do
    expect(page).to have_content('Why will you make a good home for this pet?')
    expect(page).to have_field(:description)

    fill_in(:description, with: 'I am an animal whisperer')
    click_button('Submit Application')
    save_and_open_page
    expect(page).to have_content('I am an animal whisperer')

  end

  xit 'indicates that status is pending upon description submission' do
    shelter = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    application = Application.create!(name: 'Winston Bishop', address: '1234 Turing Ave', description: 'I have the time and space', desired_pets:'Lobster', status: 'Pending', city: 'Portland', state: 'OR', zip: 92377)
    visit "/applications/#{application.id}"

    fill_in(:search, with: 'Lobster')
    click_button('Search')
    click_button('Adopt this Pet')
    fill_in(:please_explain, with: 'I have the time and space')

    expect(application.status).to eq("Pending")
  end
end

#
# As a visitor
# When I visit an application's show page
# And I have added one or more pets to the application
# Then I see a section to submit my application
# And in that section I see an input to enter why I would make a good owner for these pet(s)
# When I fill in that input
# And I click a button to submit this application
# Then I am taken back to the application's show page
# And I see an indicator that the application is "Pending"
# And I see all the pets that I want to adopt
# And I do not see a section to add more pets to this application
