class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @addresses = current_customer.addresses
    @address = Address.new
  end

  def create
    @address = current_customer.addresses.build(address_params)
    if @address.save
      flash[:notice] = '住所が作成されました。'
      redirect_to addresses_path
    else
      @address = current_customer.addresses
      flash[:notice] = "登録に失敗しました"
      redirect_back(fallback_location: root_path)
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      flash[:notice] = '編集に成功しました。'
      redirect_to addresses_path
    else
      flash[:notice] = "編集に失敗しました"
      redirect_back(fallback_location: root_path)
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    redirect_back(fallback_location: root_path)
  end

  private

  def address_params
    params.require(:address).permit(:post_code, :name, :address, :customer_id)
  end

end
