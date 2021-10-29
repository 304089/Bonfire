class PlansController < ApplicationController

  def new #日時場所選択
    @user = User.find(params[:user_id])
    @plan = Plan.new
  end

  def item_choice #newからパラメータ受け取り、登録してあるアイテムをチェックボックスで選択したパラメータを受け取る
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
    @user = User.find(params[:user_id])
    @plan = Plan.find(params[:id])
    @items = Item.joins(:plan_items).where(plan_items: { plan_id: @plan.id }) #計画と合わせて選択したアイテムも表示するため
    if params[:tab] == "plan" || params[:tab] == nil
      @tab = "plan"
      render "show"
    elsif params[:tab] == "gear"
      @tab = "gear"
      render "show"
    end
  end

  def index #全て・グルキャン・ソロで絞り込み&新旧ソート
    @user = User.find(params[:user_id])
    if params[:type] == "all"
      if params[:sort] == "new"
        @plans = Plan.where(user_id: params[:user_id]).order(day: "DESC" )
      elsif params[:sort] == "old"
        @plans = Plan.where(user_id: params[:user_id]).order(day: "ASC" )
      end
    elsif params[:type] == "group"
      if params[:sort] == "new"
        @plans = Plan.where(user_id: params[:user_id], member: 1..Float::INFINITY).order(day: "DESC" )  #参加人数２人以上（入力時、自分はすでに含まれているため）
      elsif params[:sort] == "old"
        @plans = Plan.where(user_id: params[:user_id], member: 1..Float::INFINITY).order(day: "ASC" )
      end
    elsif params[:type] == "single"
      if params[:sort] == "new"
        @plans = Plan.where(user_id: params[:user_id], member: 0).order(day: "DESC" )
      elsif params[:sort] == "old"
        @plans = Plan.where(user_id: params[:user_id], member: 0).order(day: "ASC" )
      end
    else
      @plans = Plan.where(user_id: params[:user_id]).order(day: "DESC" )
    end
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
    params.require(:plan).permit(:title, :day, :place, :check_in_time, :check_out_time, :member, :memo, :user_id, item_ids: [] )  #アイテムは複数のため配列で
  end
end
