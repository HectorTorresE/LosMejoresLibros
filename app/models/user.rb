class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  enum role: %i[client author admin]
  enum membership: %i[free basic premium]
  after_initialize :set_default_value, if: :new_record?
  has_many :books, dependent: :destroy

  def set_default_value
    self.membership ||= :free
    self.role ||= :client
  end

  def author_cut
    case self.membership
    when 'free' then 0.05
    when 'basic' then 0.15
    when 'premium' then 0.25
    end
  end

  def payment
    return unless author?

    sales_to_pay = Sale.where(authordpayed: false)
                       .where('saledate <= ?', 7.days.ago)
                       .joins(book: :user)
                       .where('users.role = ?', 2)

    sales_to_pay.each do |sale|
      cut = case sale.book.user.membership
            when 'free' then 0.05
            when 'basic' then 0.15
            when 'premium' then 0.25
            end

      amount = sale.price * sale.copysold * cut
      sale.book.user.balance += amount
      sale.book.user.save!
      sale.update(authorpayed: true, datedpayed: Time.current)
    end
  end
end
