class Tenant < ApplicationRecord
  has_many :leases
  has_many :apartments, through: :leases

  validates_presence_of :name
  validates :age, numericality: { greater_than_or_equal_to: 18 }
end
