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
  end

  def update
  end

  private


end
