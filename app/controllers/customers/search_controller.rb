class Customers::SearchController < ApplicationController

  def search
    @genre_id = params[:genre_id]
    if params[:genre_id].empty?
      @items = Item.all.page(params[:page]).reverse_order.per(8)
    else
      @genre = Genre.find(params[:genre_id])
      @items = @genre.items.page(params[:page]).reverse_order.per(8)
    end
    render "customers/items/index"
  end
  
  private

  def genre_params
    params.require(:genre).permit(:name)
  end
end
