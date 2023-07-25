class Admin::ItemsController < ApplicationController
  def index
    @items = Item.all

    # 商品検索機能
    if params[:word] == nil
      @items = @items.page(params[:page]).per(10)
    elsif params[:word] == ''
      @items = @items.page(params[:page]).per(10)
    else
      @serch_word = params[:word]
      @serch_counts = @items.where("name LIKE ?",'%' + params[:word] + '%' ).or(Item.where("explanation LIKE ?",'%' + params[:word] + '%' )).count
      @items = @items.where("name LIKE ?",'%' + params[:word] + '%' ).or(Item.where("explanation LIKE ?",'%' + params[:word] + '%' )).page(params[:page]).per(10)
    end
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to admin_item_path(@item)
    else
      render "new"
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to admin_item_path(@item)
    else
      render "edit"
    end
  end

  private

  def item_params
    params.require(:item).permit(:genre_id, :name, :explanation, :price, :is_active, :item_image)
  end

end
