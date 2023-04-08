class Book < ApplicationRecord
  belongs_to :user, foreign_key: 'author_id'
  has_many :sales, dependent: :destroy
  
  validates :title, presence: true
  validates :category, presence: true
  validates :published_date, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :discount, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 1 }, allow_nil: true

  scope :available, -> { where(available: true) }
end
