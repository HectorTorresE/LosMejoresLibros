class SalesController < ApplicationController
  def new
    @books = Book.where(available: true).order('created_at DESC')
    @my_books = Sale.where(user_id: current_user.id, refund: false).order('created_at DESC').sum(:copies)
    @sale = Sale.new
  end

  def index
    @sales = Sale.includes(:book, :user).where(refund: false).order('created_at DESC')
    @users = User.where(role: %w[client author]).order('created_at DESC')
  end

  def create
    book = Book.find(params[:sale][:book_id])
    copies = params[:sale][:quantity].to_i
    price = book.price * copies

    if current_user.balance < price
      redirect_to new_sale_path, alert: 'You do not have enough balance to purchase this book.'
      return
    end

    sale = Sale.new(book:, user: current_user, price:, copies:)

    if sale.save
      current_user.update(balance: current_user.balance - price)
      book.update(amountsold: book.amountsold + copies)
      redirect_to new_sale_path, notice: 'Book purchased successfully'
    else
      redirect_to new_sale_path, alert: 'Unable to purchase book'
    end
  end

  def pay_author
    @sale = Sale.find(params[:id])
    @author = @sale.book.user
    @author.update(balance: @author.balance + (@sale.price * @author.author_cut))
    @sale.update(authorpayed: true, datedpayed: Time.now)
    redirect_to sales_path, notice: 'Author paid successfully'
  end

  def set_autopay
    @author = User.find(params[:id])
    @author.update(autopay_days: params[:days])

    # Schedule the job to run every X days
    AutopayAuthorJob.perform_at(10.seconds.from_now, @author.id)

    redirect_to sales_path, notice: 'Autopay set successfully'
  end

  def autopay(user_id)
    user = User.find(user_id)
    sales_to_pay = Sale.joins(book: :user).where(authorpayed: false, books: { user_id: user.id }).where('sales.created_at < ?', 7.days.ago)

    sales_to_pay.each do |sale|
      amount_to_pay = sale.price * user.author_cut
      user.update(balance: user.balance + amount_to_pay)
      sale.update(authorpayed: true, datedpayed: Time.now)
    end

    redirect_to sales_path, notice: 'Autopay completed successfully'
  end
end
