class Public::CustomersController < ApplicationController
  def show
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
end
