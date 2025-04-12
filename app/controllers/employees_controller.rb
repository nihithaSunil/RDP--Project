class EmployeesController < ApplicationController
  before_action :set_employee, only: [:show, :edit, :update]
  before_action :check_role, only: [:update]

  def index
    @active_employees = Employee.active.alphabetical
    @inactive_employees = Employee.inactive.alphabetical
  end

  def new
    @employee = Employee.new
    @employee.build_user
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      flash[:notice] = "#{@employee.proper_name} was added to the system."
      redirect_to employee_path(@employee)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @employee.update(employee_params)
      flash[:notice] = "#{@employee.proper_name} was revised in the system."
      redirect_to employee_path(@employee)
    else
      render :edit
    end
  end

  private

  def set_employee
    @employee = Employee.find(params[:id])
  end

  def check_role
    # Ensure regular employees (e.g., bakers/shippers) can't change protected fields
    if ['baker', 'shipper'].include?(current_user.role)
      params[:employee].delete(:ssn)
      params[:employee].delete(:date_hired)
      params[:employee].delete(:date_terminated)
    end
  end

  def employee_params
    base_attrs = [:first_name, :last_name, :active]
    admin_attrs = [:ssn, :date_hired, :date_terminated, user_attributes: [:username, :password, :password_confirmation, :role]]

    if ['baker', 'shipper'].include?(current_user.role)
      params.require(:employee).permit(*base_attrs)
    else
      params.require(:employee).permit(*(base_attrs + admin_attrs))
    end
  end
end
