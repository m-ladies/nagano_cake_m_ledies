class Customers::ItemsController < ApplicationController
  
  def top
  end 
  
  def about
  end
  
  def index
    @items = Item.all.page(params[:page])
  end 
  
  def show
  end 
  
end
