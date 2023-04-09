class Sale < ApplicationRecord
  belongs_to :book
  belongs_to :user

  validates :price, presence: true, numericality: { greater_than: 0 }
  validates :copies, presence: true, numericality: { greater_than: 0 }

  def autopay(user_id)
    user = User.find(user_id)
    sales_to_pay = Sale.joins(book: :user).where(authorpayed: false, books: { user_id: user.id }).where('sales.created_at < ?', 7.days.ago)

    sales_to_pay.each do |sale|
      amount_to_pay = sale.price * user.author_cut
      user.update(balance: user.balance + amount_to_pay)
      sale.update(authorpayed: true, datedpayed: Time.now)
    end
  end
end
