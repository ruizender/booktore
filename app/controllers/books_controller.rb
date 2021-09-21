class BooksController < ApplicationController
  skip_before_action :authenticate_user!, only: [:index, :reserve]
  
  def index
    if user_signed_in?
      @book = Book.all
    else
      @book = Book.all
    end
  end

  def myreserve
    @reserves = Reserve.where(user_id: current_user.id)
  end

  def reserve
    reserve = Reserve.create(book_id: params[:id], user_id: current_user.id)
    if reserve.save!
      respond_to do |format|
        format.html {redirect_to root_path, notice:  "Your book was reserved. congrats!"}
      else
        format.html { render :index, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    if @reserve.destroy
    @reserves = Reserve.all.order(updated_at: :desc)
    respond_to do |format|
      format.js { render nothing: true }
      format.html { redirect_to myreserves_url, notice: "reserve was successfully destroyed." }
    end
  end
  end

  private

  def book_params
    params.require(:book).permit(:title, :author, user_ids:[])
  end
end
