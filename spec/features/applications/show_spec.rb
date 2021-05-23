require 'rails_helper'

RSpec.describe 'the application show' do
  it "shows an application and all its attributes" do
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
end
