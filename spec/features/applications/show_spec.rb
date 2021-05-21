require 'rails_helper'

RSpec.describe 'the application show' do
  it "shows an application and all its attributes" do
    shelter = Shelter.create(name: 'Mystery Building', city: 'Irvine CA', foster_program: false, rank: 9)
    application = Application.create!(name: 'John Applicant', address: '1234 Turing Ave Denver, CO 81224', description: 'I have the time and space', desired_pets:'Scooby', status: 'status')
    pet = Pet.create!(name: 'Scooby', age: 2, breed: 'Great Dane', adoptable: true, shelter_id: shelter.id)

    visit "/applications/#{application.id}"

    expect(page).to have_content(pet.name)
    expect(page).to have_content(pet.address)
    expect(page).to have_content(pet.description)
    expect(page).to have_content(pet.desired_pets)
    expect(page).to have_content(pet.status)
  end
end
