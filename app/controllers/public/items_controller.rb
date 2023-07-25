class Public::ItemsController < ApplicationController

  def index
    if params[:word] == nil
      @items = Item.all
    elsif params[:word] == ''
      @items = Item.all
    else
      @serch_word = params[:word]
      @serch_counts = Item.where("name LIKE ?",'%' + params[:word] + '%' ).or(Item.where("explanation LIKE ?",'%' + params[:word] + '%' )).count
      @items = Item.where("name LIKE ?",'%' + params[:word] + '%' ).or(Item.where("explanation LIKE ?",'%' + params[:word] + '%' )).page(params[:page])
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