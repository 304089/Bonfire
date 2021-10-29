class Admin::PhotoPostsController < ApplicationController
  before_action :admin_user

  def index
    if params[:sort] == "new" || params[:sort] == nil                                    #新しい順
      @photo_posts = PhotoPost.where(preview: false).page(params[:page]).per(30)
    elsif params[:sort] == "old"                                                        #古い順
      @photo_posts = PhotoPost.where(preview: false).order(id: "DESC").page(params[:page]).per(30)
    elsif params[:sort] == "look"                                                     #閲覧数多い順
      @photo_posts = PhotoPost.where(preview: false).order(impressions_count: "DESC").page(params[:page]).per(30)
    elsif params[:sort] == "comment"                                                     #コメント多い順
      @photo_posts = PhotoPost.joins(:photo_post_comments).group(:id).where(preview: false).order("count(photo_post_comments.id)DESC").page(params[:page]).per(30)
    elsif params[:sort] == "favorite"                                                     #いいね多い順
      @photo_posts = PhotoPost.joins(:favorites).group(:id).where(preview: false).order("count(favorites.id)DESC").page(params[:page]).per(30)
    elsif params[:sort] == "bookmark"                                                     #ブックマーク多い順
      @photo_posts = PhotoPost.joins(:bookmarks).group(:id).where(preview: false).order("count(bookmarks.id)DESC").page(params[:page]).per(30)
    end
  end

  def search
    @photo_posts = PhotoPost.search(params[:keyword]).group(:id).page(params[:page]).per(30)
    @keyword = params[:keyword]
  end

end
