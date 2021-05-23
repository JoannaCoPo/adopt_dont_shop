require "rails_helper"

RSpec.describe Application, type: :model do
  describe "relationships" do
    it { should have_many :pets}
    it {should have_many(:pets).through(:application_pets)}
  end

  describe '#adoption_form' do
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:state) }
    # it { is_expected.to validate_presence_of(:zip) }
  end
end
