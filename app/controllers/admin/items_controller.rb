class Admin::ItemsController < ApplicationController



  def index
  end

  def new
    @item = Item.new
    @genres = Genre.all
  end

  def edit
  end

  def show
  end

  def create
    @item = Item.new(item_params)
    @item.save
    redirect_to admin_item_path(@item.id)
  end

  def update
  end

  private
  def item_params
    params.require(:item).permit(:name, :introduction, :price, :image_id, :is_active, :genre_id)
  end


end
