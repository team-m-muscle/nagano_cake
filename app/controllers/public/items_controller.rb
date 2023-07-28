class Public::ItemsController < ApplicationController

  def index
    @items = Item.all.page(params[:page]).per(8)
    @items_count = Item.all
    # 商品検索機能
    unless params[:word] == nil
      unless params[:word] == ''
        @serch_word = params[:word]
        @serch_counts = Item.where("name LIKE ?",'%' + params[:word] + '%' ).or(Item.where("explanation LIKE ?",'%' + params[:word] + '%' )).count
        @items = Item.where("name LIKE ?",'%' + params[:word] + '%' ).or(Item.where("explanation LIKE ?",'%' + params[:word] + '%' )).page(params[:page])
      end
    end

    @genres = Genre.all
  end

  def show
    @genres = Genre.all
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  def search
    @genres = Genre.all
    @genre = Genre.find(params[:id])
    @items = @genre.items.page(params[:page]).per(10)
    @items_count = @genre.items.all
  end
end