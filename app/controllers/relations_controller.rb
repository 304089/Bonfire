class RelationsController < ApplicationController
  before_action :active_user, only:[:create, :destroy]

  def create
    @user = User.find(params[:user_id])
    relation = Relation.new(followed_id: @user.id,follower_id: current_user.id)
    relation.save
  end

  def destroy
    @user = User.find(params[:user_id])
    relation = Relation.find_by(followed_id: @user.id,follower_id: current_user.id)
    relation.destroy
  end

  def followings
    @user = User.find(params[:user_id])
    @users = @user.followings.all
  end

  def followers
    @user = User.find(params[:user_id])
    @users = @user.followers.all
  end

end
