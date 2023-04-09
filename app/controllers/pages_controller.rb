class PagesController < ApplicationController
  def home
    redirect_to new_sale_path if user_signed_in? && current_user.client?
    redirect_to new_book_path if user_signed_in? && current_user.author?
    redirect_to sales_path if user_signed_in? && current_user.admin?
  end
end
