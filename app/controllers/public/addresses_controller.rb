class Public::AddressesController < ApplicationController

  def index
    @shipping_address = Address.new
    @customer = current_customer
    @shipping_addresses = Address.all
  end

  def create
    @shipping_address = Address.new(address_params)
    @shipping_address.save
    @shipping_address = Address.new
    redirect_to addresses_path
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private

  def address_params
    params.require(:address).permit(:name, :address, :post_code)
  end

end
