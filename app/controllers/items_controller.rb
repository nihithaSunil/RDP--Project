class ItemsController < ApplicationController
  before_action :set_item, only: [:show, :edit, :update, :destroy]
  authorize_resource

  # def index
  #   @breads = Item.breads.active.alphabetical
  #   @muffins = Item.muffins.active.alphabetical
  #   @pastries = Item.pastries.active.alphabetical
  #   @inactive_items = current_user&.manager_role? ? Item.inactive.alphabetical : nil

  # end
  def index
    @breads = Item.where(category: 'breads').active
    @muffins = Item.where(category: 'muffins').active
    @pastries = Item.where(category: 'pastries').active
    @popular_items = Item.popular_items_on(Date.current).first(5)
    @inactive_items = Item.inactive if current_user&.manager_role?
    @item = @breads.first
  end

  def show
    @similar_items = Item.where(category: @item.category).where.not(id: @item.id).active.alphabetical
    @price_history = current_user&.manager_role? ? @item.item_prices.chronological : nil
  end
  
  def new
    @item = Item.new
  end

  # def create
  #   @item = Item.new(item_params)
  #   if @item.save
  #     flash[:notice] = "#{@item.name} was added to the system."
  #     redirect_to item_path(@item)
  #     render :new
  #   end
  # end
  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "#{@item.name} was added to the system."
      redirect_to item_path(@item)
    else
      render :new
    end
  end
  

  def edit
  end

  def update
    if @item.update(item_params)
      flash[:notice] = "#{@item.name} was revised in the system."
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
      flash[:notice] = "#{@item.name} was removed from the system."
      redirect_to items_path
    else
      flash[:error] = "#{@item.name} has been used for prior orders and cannot be deleted."
      redirect_to item_path(@item)
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(:name, :category, :units_per_item, :weight, :active)
  end
end