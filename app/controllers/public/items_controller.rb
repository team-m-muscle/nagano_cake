class Public::ItemsController < ApplicationController

  def index
    @items = Item.all

    # 商品検索機能
    unless params[:word] == nil
      unless params[:word] == ''
        @serch_word = params[:word]
        @serch_counts = @items.where("name LIKE ?",'%' + params[:word] + '%' ).or(Item.where("explanation LIKE ?",'%' + params[:word] + '%' )).count
        @items = @items.where("name LIKE ?",'%' + params[:word] + '%' ).or(Item.where("explanation LIKE ?",'%' + params[:word] + '%' )).page(params[:page])
      end
    end

    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end

  def search
    @genre = Genre.find(params[:id])
    @items = @genre.items
  end
end