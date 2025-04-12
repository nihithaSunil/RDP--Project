class AddressesController < ApplicationController
  before_action :set_address, only: [:show, :edit, :update, :destroy]
  before_action :check_login

  def index
    @active_addresses = Address.active
    @inactive_addresses = Address.inactive
  end

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    # If no customer_id is provided, default to the logged-in customer's ID
    if @address.customer_id.nil?
      @address.customer = current_user.customer
    end

    if @address.save
      flash[:notice] = "Address was added for customer #{@address.customer.proper_name}."
      redirect_to customer_path(@address.customer)
    else
      render :new
    end
  end

  def show
    @other_addresses = @address.customer.addresses.where.not(id: @address.id)
  end

  def edit
  end

  def update
    if @address.update(address_params)
      flash[:notice] = "Address updated successfully."
      redirect_to customer_path(@address.customer)
    else
      render :edit
    end
  end

  def destroy
    if @address.destroy
      flash[:notice] = "Address was removed from the system."
    else
      # Get specific error messages from model callbacks
      flash[:error] =  "Address has been used for prior orders and cannot be deleted."
    end
    redirect_to customer_path(@address.customer)
  end

  private

  def set_address
    @address = Address.find(params[:id])
  end

  def address_params
    params.require(:address).permit(:active, :recipient, :street_1, :street_2, :city, :state, :zip, :customer_id, :is_billing)
  end
end
