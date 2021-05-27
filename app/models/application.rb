class Application < ApplicationRecord
  has_many :application_pets
  has_many :pets, through: :application_pets
  validates :name, :address, :city, :state, :zip, presence: true
end

def pet_count
  pets.count
end
