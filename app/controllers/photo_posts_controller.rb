class PhotoPostsController < ApplicationController

  def new
    @photo_post = PhotoPost.new
    @user = current_user
  end

  def preview
    @photo_post = PhotoPost.find(params[:id])
    @preview = true                             #***updateアクション時の条件分岐用でhiddenで：previewのパラメータを送る
    if params[:status] == "draft"               #***************詳細ページ遷移時に draftパラメータが送られたら、タイトルは「下書き」
      @title = "draft"                          #そうじゃない場合　= 投稿作成時のプレビュー表示の際　は　タイトルは　「プレビュー」
    end
  end

  def create
    @photo_post = PhotoPost.new(photo_post_params)
    @photo_post.user_id = current_user.id
    if @photo_post.save
      redirect_to preview_photo_post_path(@photo_post)
    else
      render "new"
    end
  end

  def edit
    @photo_post = PhotoPost.find(params[:id])
    @user = current_user
  end

  def update
    @photo_post = PhotoPost.find(params[:id])
    if @photo_post.preview == true                #*********** true=下書き・プレビュー状態の投稿, false=すでに投稿済みの投稿
      if params[:photo_post][:preview] == "preview" #******下書き・プレビューの投稿編集なら
        if @photo_post.update(photo_post_params)  #**********編集された内容だけ更新
          redirect_to preview_photo_post_path(@photo_post) #*****プレビュー画面へ
        else
          render "edit"
        end
      else                                #********下書き・プレビューから本投稿されたら
        if @photo_post.update(preview: false) #*******ステータスを投稿に切り替えて
          redirect_to user_path(@photo_post.user) #*******マイページへ
        end
      end
    else                                          #*****すでに投稿済みの投稿の編集の時
      @photo_post.record_timestamps = false       #*************今回の仕様上、更新日＝投稿日にするため、投稿済みの投稿の内容編集は更新日を変えさせない
      if params[:photo_post][:preview] == "preview"
        if @photo_post.update(photo_post_params)
          redirect_to preview_photo_post_path(@photo_post)  #*********プレビュー画面を経由させる
        else
          render "edit"
        end
      else
        if @photo_post.update(photo_post_params)
          redirect_to user_path(@photo_post.user) #*******マイページへ
        end
      end
    end
  end

  def show
    @photo_post = PhotoPost.find(params[:id])
    @photo_post_comment = PhotoPostComment.new
    @photo_post_comments = PhotoPostComment.where(photo_post_id: @photo_post.id)
  end

  def index
    if params[:genre] == "キャンプ場"
      if params[:type] == "new" || params[:type] == ""
        @photo_posts = PhotoPost.where(genre: "キャンプ場", preview: false).order(id: "DESC").page(params[:page]).per(28)
      elsif params[:type] == "old"
        @photo_posts = PhotoPost.where(genre: "キャンプ場", preview: false).page(params[:page]).per(28)
      elsif  params[:type] == "favorite"
        @photo_posts = PhotoPost.joins(:favorites).group(:id).where(genre: "キャンプ場", preview: false)
                                .order("count(favorites.id) DESC").page(params[:page]).per(28)
      end
    elsif params[:genre] == "キャンプ道具"
      if params[:type] == "new" || params[:type] == ""
        @photo_posts = PhotoPost.where(genre: "キャンプ道具",preview: false).order(id: "DESC").page(params[:page]).per(28)
      elsif params[:type] == "old"
        @photo_posts = PhotoPost.where(genre: "キャンプ道具",preview: false).page(params[:page]).per(28)
      elsif params[:type] == "favorite"
        @photo_posts = PhotoPost.joins(:favorites).group(:id).where(genre: "キャンプ道具",preview: false)
                                .order("count(favorites.id) DESC").page(params[:page]).per(28)
      end
    elsif params[:genre] == "キャンプ料理"
      if params[:type] == "new" || params[:type] == ""
        @photo_posts = PhotoPost.where(genre: "キャンプ料理", preview: false).order(id: "DESC").page(params[:page]).per(28)
      elsif params[:type] == "old"
        @photo_posts = PhotoPost.where(genre: "キャンプ料理", preview: false).page(params[:page]).per(28)
      elsif params[:type] == "favorite"
        @photo_posts = PhotoPost.joins(:favorites).group(:id).where(genre: "キャンプ料理", preview: false)
                                .order("count(favorites.id) DESC").page(params[:page]).per(28)
      end
    elsif params[:genre] == "キャンプ初心者"
      if params[:type] == "new" || params[:type] == ""
        @photo_posts = PhotoPost.where(genre: "キャンプ初心者", preview: false).order(id: "DESC").page(params[:page]).per(28)
      elsif params[:type] == "old"
        @photo_posts = PhotoPost.where(genre: "キャンプ初心者", preview: false).page(params[:page]).per(28)
      elsif params[:type] == "favorite"
        @photo_posts = PhotoPost.joins(:favorites).group(:id).where(genre: "キャンプ初心者", preview: false)
                                .order("count(favorites.id) DESC").page(params[:page]).per(28)
      end
    elsif params[:genre] == ""
      if params[:type] == "new" || params[:type] == ""
        @photo_posts = PhotoPost.where(preview: false).order(id: "DESC").page(params[:page]).per(28)
      elsif params[:type] == "old"
        @photo_posts = PhotoPost.where(preview: false).page(params[:page]).per(28)
      elsif params[:type] == "favorite"
        @photo_posts = PhotoPost.joins(:favorites).group(:id).where(preview: false)
                                .order("count(favorites.id) DESC").page(params[:page]).per(28)
      end
    else
      @photo_posts = PhotoPost.where(preview: false).order(id: "DESC").page(params[:page]).per(28)
    end

  end

  def destroy
    @photo_post = PhotoPost.find(params[:id])
    @photo_post.destroy
    redirect_to user_path(@photo_post.user)
  end

  def search
    if params[:tag]
      @photo_posts = PhotoPost.tagged_with(params[:tag]).where(preview: false).order(id: "DESC").page(params[:page]).per(28)
    else
      @photo_posts = PhotoPost.search(params[:keyword]).where(preview: false).order(id: "DESC").page(params[:page]).per(28)
    end
    @keyword = params[:keyword]
    @tag = params[:tag]
  end

  private
  def photo_post_params #画像は複数投稿可能なため、配列で受け取る.
    params.require(:photo_post).permit(:introduction, :photo_image, :genre, :tag_list,:place, :preview, :status, :type,
      post_images_images: [])
  end

end
