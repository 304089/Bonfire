class PlansController < ApplicationController

  def new
    @user = User.find(params[:user_id])
    @plan = Plan.new
  end

  def item_choice
    @user = User.find(params[:user_id])
    @plan = Plan.new(plan_params)
    @plan_item = PlanItem.new
    @items = Item.where(user_id: params[:user_id])
    @plan.plan_items.build
  end

  def create
    @plan = Plan.new(plan_params)
    @plan.user_id = params[:user_id]
    if @plan.save
      redirect_to user_plan_path(params[:user_id], @plan)
    else
      @user = User.find(params[:user_id])
      render "new"
    end
  end

  def show
    @plan = Plan.find(params[:id])
    @items = Item.joins(:plan_items).where(plan_items: { plan_id: @plan.id })
  end

  def index
    @user = User.find(params[:user_id])
    @plans = Plan.where(user_id: params[:user_id])
  end

  def edit
    @user = User.find(params[:user_id])
    @plan = Plan.find(params[:id])
  end

  def update
    @plan = Plan.find(params[:id])
    if @plan.update(plan_params)
      redirect_to user_plan_path(params[:user_id], @plan)
    else
      @user = User.find(params[:user_id])
      render "edit"
    end
  end

  def destroy
    @plan = Plan.find(params[:id])
    @plan.destroy
    redirect_to user_plans_path(params[:user_id])
  end

  private
  def plan_params
    params.require(:plan).permit(:title, :day, :place, :check_in_time, :check_out_time, :member, :memo, :user_id, item_ids: [] )
  end
end
