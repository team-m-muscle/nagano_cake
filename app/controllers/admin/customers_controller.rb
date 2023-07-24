class Admin::CustomersController < ApplicationController
  def index
    @customers = Customer.all.page(params[:page]).per(10)
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:customer_information_update] = "変更内容を保存しました"
      redirect_to admin_customer_path
    else
      render :edit
    end
  end

  private
  def customer_params
    params.require(:customer).permit(:email, :last_name, :first_name, :last_name_reading, :first_name_reading, :post_code, :address, :phone_number, :is_deleted)
  end
end
