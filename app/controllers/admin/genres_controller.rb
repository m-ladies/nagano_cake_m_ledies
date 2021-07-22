class Admin::GenresController < ApplicationController

  def index
    @genres = Genre.all
    @genre = Genre.new
    # .newの命名は@genre = Genre.new(genre_params)と同じ命名にするように
  end

  def create
    @genre = Genre.new(genre_params)
    # ２. データをデータベースに保存するためのsaveメソッド実行
    if @genre.save
       flash[:notice] = "ジャンルを追加しました"
       # ３. トップ画面へリダイレクト
       redirect_to admin_genres_path
    else
      @admin = current_admin
      @genres = Genre.all
      render :index
    end
  end

  def edit
    @genre = Genre.find(params[:id])
  end

  def update
   @genre = Genre.find(params[:id])
   if @genre.update(genre_params)
      flash[:notice] = "ジャンルを変更しました"
      redirect_to admin_genres_path
   else
     render :edit
   end
  end

  private

  def genre_params
   params.require(:genre).permit(:name)
  end

end
