class Public::CustomersController < ApplicationController
  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      flash[:customer_information_update] = "変更内容を保存しました"
      redirect_to customers_my_page_path
    else
      render :edit
    end
  end

  def confirm
  end

  def leave
    @customer = current_customer
    @customer.update(is_deleted: true)
    reset_session
    flash[:left] = "退会しました　長らくのご愛顧誠にありがとうございました"
    redirect_to root_path
  end

  private
  def customer_params
    params.require(:customer).permit(:email, :last_name, :first_name, :last_name_reading, :first_name_reading, :post_code, :address, :phone_number, :is_deleted)
  end
end