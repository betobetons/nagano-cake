class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    if @customer.update(customer_params)
      flash[:notice] = "更新に成功しました"
      redirect_to customers_my_page_path
    else
      flash[:notice] = "更新に失敗しました"
      @customer = current_customer
      redirect_back(fallback_location: root_path)
    end
  end

  def unsubscribe
  end

  def withdraw
    @customer = current_customer
    #is_deletedカラムをtrueに変更する
    @customer.update(is_active: false)
    #ログアウトさせる
    reset_session
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :first_name_kana, :last_name_kana, :post_code, :address, :phone, :email)
  end

end
