class Sale < ApplicationRecord
  belongs_to :book, polymorphic: true
  belongs_to :author, class_name: 'User', foreign_key: 'user_id'

  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :copies_sold, presence: true, numericality: { greater_than: 0 }
  validates :sale_date, presence: true
  validates :book, presence: true

  before_save :set_author_paid_date, if: :author_paid_changed?
  
  def set_author_paid_date
    self.dated_paid = Time.now if author_paid?
  end
end
