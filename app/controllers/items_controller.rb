class ItemsController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = params[:user_id]
    if @item.save
      redirect_to user_item_path(params[:user_id], @item)
    else
      @user = User.find(params[:user_id])
      render "new"
    end
  end

  def index
    @user = User.find(params[:user_id])
    if params[:genre]
      @items = Item.where(user_id: params[:user_id], genre: params[:genre])
    else
       @items = Item.where(user_id: params[:user_id])
    end
  end

  def edit
    @user = User.find(params[:user_id])
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      redirect_to user_items_path(params[:user_id])
    else
      @user = User.find(params[:user_id])
      render "edit"
    end
  end

  def destroy
    @item = Item.find(params[:id])
    @item.destroy
    redirect_to user_items_path(params[:user_id])
  end

  private
  def item_params
    params.require(:item).permit(:name, :manufacturer, :genre, :item_image)
  end
end
