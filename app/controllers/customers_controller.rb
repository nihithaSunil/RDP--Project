class CustomersController < ApplicationController
  before_action :set_customer, only: [:show, :edit, :update]
  before_action :check_login, except: [:new, :create]
  authorize_resource except: [:new, :create]

  def index
    @active_customers = Customer.active.alphabetical.to_a
    @inactive_customers = Customer.inactive.alphabetical.to_a
  end

  def new
    @customer = Customer.new
    @customer.build_user
  end

  def create
    @customer = Customer.new(customer_params)

    # Force the role to be customer (ignore passed-in role if any)
    @customer.user.role = 'customer' if @customer.user

    if @customer.save
      if logged_in?
        flash[:notice] = "Welcome to Roi du Pain -- We hope you enjoy shopping with us."
      else
        session[:user_id] = @customer.user.id
        session[:cart] = Hash.new
        flash[:notice] = "Welcome to Roi du Pain -- We hope you enjoy shopping with us."
      end
      redirect_to customer_path(@customer)
    else
      render action: 'new'
    end
  end

  def show
    @previous_orders = @customer.orders.paid.chronological.to_a
    @addresses = @customer.addresses.active.by_recipient.to_a
  end

  def edit
  end

  def update
    if @customer.update(customer_params)
      flash[:notice] = "#{@customer.proper_name} was revised in the system."
      redirect_to customer_path(@customer)
    else
      render action: 'edit'
    end
  end

  private

  def set_customer
    @customer = Customer.find(params[:id])
  end

  def customer_params
    params.require(:customer).permit(:first_name, :last_name, :email, :phone, :active,
                                     user_attributes: [:username, :password, :password_confirmation])
  end
end
