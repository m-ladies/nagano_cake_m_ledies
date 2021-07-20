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
    if @item.save!
     redirect_to admin_item_path(@item.id)
    else
      @genres = Genre.all
      render :new
    end
  end

  def update
   @item = Item.find(params[:id])
   if @item.update(item_params)
      redirect_to admin_item_path(@item.id)
   else
     @genres = Genre.all
     render :edit
   end
  end

  private
  def item_params
    params.require(:item).permit(:name, :introduction, :image, :price, :genre_id, :is_active)
  end


end
