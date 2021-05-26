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
    application = Application.create!(name: 'Winston Bishop', address: '1234 Turing Ave', description: 'I have the time and space', desired_pets:'Lobster', status: 'Pending', city: 'Portland', state: 'OR', zip: 92377)
    visit "/applications/#{application.id}"

    fill_in(:search, with: 'Lobster')
    click_button('Search')
    expect(page).to have_button('Adopt this Pet')

    click_button('Adopt this Pet')
    within('p#added-pet') do
      expect(page).to have_content('Lobster')
    end
  end

  it 'displays input for description in the submission section' do
    shelter = Shelter.create(name: 'Fancy pets of Colorado', city: 'Denver, CO', foster_program: true, rank: 10)
    pet_1 = Pet.create(adoptable: true, age: 1, breed: 'sphynx', name: 'Lucille Bald', shelter_id: shelter.id)
    pet_2 = Pet.create(adoptable: true, age: 3, breed: 'doberman', name: 'Lobster', shelter_id: shelter.id)
    application = Application.create!(name: 'Winston Bishop', address: '1234 Turing Ave', description: 'I have the time and space', desired_pets:'Lobster', status: 'Pending', city: 'Portland', state: 'OR', zip: 92377)
    visit "/applications/#{application.id}"

    fill_in(:search, with: 'Lobster')

    click_button('Search')
    click_button('Adopt this Pet')

    within('section#submission') do
      expect(page).to have_content('Why will you make a good home for this pet?')
      # expect(page).to have_button(:please_explain)
    end
  end
end
