require 'rails_helper'

RSpec.describe 'the application show' do
  it "shows an application and all its attributes" do
    application = Application.create!(name: 'John Applicant', address: '1234 Turing Ave Denver, CO 81224', description: 'I have the time and space', desired_pets:'Scooby', status: 'Pending')

    visit "/applications/#{application.id}"

    expect(page).to have_content(application.name)
    expect(page).to have_content(application.address)
    expect(page).to have_content(application.description)
    expect(page).to have_content(application.desired_pets)
    expect(page).to have_content(application.status)
  end
end
