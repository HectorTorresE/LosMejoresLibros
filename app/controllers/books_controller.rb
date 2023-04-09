class BooksController < ApplicationController
  def index
    @books = Book.where(available: true).order('created_at DESC')
  end

  def new
    @book = Book.new
    @my_books = Book.where(user_id: current_user.id).order('created_at DESC')
    @sales = Sale.includes(:book).where(books: { user_id: current_user.id }, refund: false)
    @books_sold = @sales.where(refund: false).sum(:copies)
    @pending = @sales.where(authorpayed: false).sum(:copies)
  end

  def create
    return unless current_user.author?

    @book = Book.new(book_params)
    @book.user_id = current_user.id

    if @book.valid?
      @book.save
      redirect_back fallback_location: books_path, notice: 'Book Added'
    else
      flash.now[:alert] = 'Could not save book:'
      @book.errors.full_messages.each do |msg|
        flash.now[:alert] << "<br/>#{msg}"
      end
      render :new, status: 400
    end
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to new_book_path, notice: 'Book updated successfully'
    else
      render :edit
    end
  end

  def refund
    sale = Sale.find(params[:id])
    author = sale.book.user
    client = sale.user

    author.update(balance: author.balance - (sale.price * author.author_cut)) if sale.authorpayed?
    client.update(balance: client.balance + sale.price)
    sale.update(refund: true)

    redirect_to new_book_path, notice: 'Book refund successfully'
  end

  private

  def book_params
    params.require(:book).permit(:user, :title, :description, :price, :available)
  end
end
