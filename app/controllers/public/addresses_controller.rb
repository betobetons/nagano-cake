class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @addresses = current_customer.addresses
    @address = Address.new
  end

  def create
    @address = current_customer.addresses.build(address_params)
    if @address.save
      respond_to do |format|
        format.html { redirect_to addresses_path, notice: 'Address was successfully created.' }
        format.js   # create.js.erb をレンダリングします
      end
    else
      respond_to do |format|
        format.html do
          @addresses = current_customer.addresses
          render :index
        end
        format.js { render 'create_error', status: :unprocessable_entity }  # エラー用の JavaScript ビューを用意します
      end
    end
  end

  def edit
    @address = Address.find(params[:id])
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path, notice: 'Address was successfully updated.'
    else
      @addresses = current_customer.addresses
      render :edit
    end
  end

  def destroy
    @address = Address.find(params[:id])
    @address.destroy
    respond_to do |format|
      format.html { redirect_back(fallback_location: root_path, notice: 'Address was successfully deleted.') }
      format.js   # destroy.js.erb をレンダリングします
    end
  end

  private

  def address_params
    params.require(:address).permit(:post_code, :name, :address, :customer_id)
  end
end
