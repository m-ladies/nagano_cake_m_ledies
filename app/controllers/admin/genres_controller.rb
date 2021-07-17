class Admin::GenresController < ApplicationController

  def index
    @genres = Genre.all
    @genre_new = Genre.new
  end

  def create
    @genre = Genre.new(genre_params)
    # ２. データをデータベースに保存するためのsaveメソッド実行
    @genre.save
    # ３. トップ画面へリダイレクト
    redirect_to admin_genres_path
  end

  def edit
  end

  def update
  end

  private

  def genre_params
   params.require(:genre).permit(:name)
  end

end
