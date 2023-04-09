class Sale < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :copies, presence: true, numericality: { greater_than: 0 }
end
