class Public::AddressesController < ApplicationController

  def index
    @shipping_address = Address.new
    @customer = current_customer
    @shipping_addresses = @customer.addresses
  end

  def create
    @shipping_address = Address.new(address_params)
    @shipping_address.customer_id = current_customer.id
    if @shipping_address.save
      flash[:notice] = "登録完了しました。"
      redirect_to addresses_path
    else
      @customer = current_customer
      @shipping_addresses = @customer.addresses
      flash[:notice] = "内容に不備があります。"
      render 'index'
    end

  end

  def edit
    @shipping_address = Address.find(params[:id])
  end

  def update
    @shipping_address = Address.find(params[:id])
    if @shipping_address.update(address_params)
      flash[:notice] = "変更完了しました。"
      redirect_to addresses_path
    else
      flash[:notice] = "内容に不備があります。"
      render 'edit'
    end

  end

  def destroy
    @shipping_address = Address.find(params[:id])
    @shipping_address.customer_id = current_customer.id
    @shipping_address.destroy
    flash[:notice] = "登録先を削除しました。"
    redirect_to addresses_path
  end

  private

  def address_params
    params.require(:address).permit(:name, :address, :post_code)
  end

end
