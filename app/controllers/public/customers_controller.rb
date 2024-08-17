class Public::CustomersController < ApplicationController
  before_action :authenticate_customer!

  def show
    @customer = current_customer
  end

  def edit
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

  end

end
