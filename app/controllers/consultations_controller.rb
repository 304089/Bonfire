class ConsultationsController < ApplicationController
  before_action :active_user, except:[:index, :show, :search]

  def new
    @consultation = Consultation.new
    @user = current_user
  end

  def create
    @consultation = Consultation.new(consultation_params)
    @consultation.user_id = current_user.id
    if @consultation.save
      redirect_to consultations_path
    else
      @user = current_user
      render "new"
    end
  end

  def index #カテゴリー絞り込みからソート可能　listパラメータはタブ切り替え時の判別用
    if params[:genre] #カテゴリーを選択した場合
      if params[:list] == "new" #新着順
        @consultations = Consultation.where(genre: params[:genre]).order(created_at: "DESC").page(params[:page]).per(15)
        @list = "new"
      elsif params[:list] == "look"  #閲覧順
        @consultations = Consultation.where(genre: params[:genre]).order(impressions_count: "DESC").page(params[:page]).per(15)
        @list = "look"
      elsif params[:list] == "helpfulness"  #役に立った！が多い順
        @consultations = Consultation.joins(consultation_answers: :helpfulnesses).group(:consultation_id)
                                     .where(genre: params[:genre]).order("count(helpfulnesses.id) DESC").page(params[:page]).per(15)
        @list = "helpfulness"
      else
        @consultations = Consultation.where(genre: params[:genre]).order(created_at: "DESC").page(params[:page]).per(15)
      end
      @genre = params[:genre] #カテゴリーで絞り込んだ後に、さらにそのカテゴリー内でソートをかけるためのパラメータ
    else  #カテゴリーを選択していない場合
      if params[:user_id] #My相談を選択時
        if params[:sort] == "new" || params[:sort] == nil
          @consultations = Consultation.where(user_id: params[:user_id]).order(created_at: "DESC").page(params[:page]).per(15)
        elsif params[:sort] == "old"
          @consultations = Consultation.where(user_id: params[:user_id]).page(params[:page]).per(15)
        elsif params[:sort] == "look"
          @consultations = Consultation.where(user_id: params[:user_id]).order(impressions_count: "DESC").page(params[:page]).per(15)
        elsif params[:sort] == "helpfulness"
          @consultations = Consultation.joins(consultation_answers: :helpfulnesses).group(:consultation_id)
                                       .where(user_id: params[:user_id]).order("count(helpfulnesses.id) DESC").page(params[:page]).per(15)
        end
        @list = "mine"
      elsif params[:list] == "new"  #カテゴリー、My相談未選択時
        @consultations = Consultation.order(created_at: "DESC").page(params[:page]).per(15)
        @list = "new"
      elsif params[:list] == "look"  #カテゴリー、My相談未選択時
        @consultations = Consultation.order(impressions_count: "DESC").page(params[:page]).per(15)
        @list = "look"
      elsif params[:list] == "helpfulness"  #カテゴリー、My相談未選択時
        @consultations = Consultation.joins(consultation_answers: :helpfulnesses).group(:consultation_id)
                                     .order("count(helpfulnesses.id) DESC").page(params[:page]).per(15)
        @list = "helpfulness"
      else  #Consultページに遷移してきただけの時
        @consultations = Consultation.order(created_at: "DESC").page(params[:page]).per(15)
      end
    end
    #ページ右側のランキング（相談の回答に”役に立った！”が多い人 週間・月間・全期間）
    if params[:period] == "week"
      @ranks = User.joins(consultation_answers: :helpfulnesses).where(helpfulnesses: {created_at: Time.current.all_week}).group(:id)
                   .order("count(helpfulnesses.id) DESC").limit(10)
      @period = "week"
    elsif params[:period] == "manth"
      @ranks = User.joins(consultation_answers: :helpfulnesses).group(:id).where(helpfulnesses: {created_at: Time.current.all_month}).order("count(helpfulnesses.id) DESC").limit(10)
      @period = "manth"
    elsif params[:period] == "all"
      @ranks = User.joins(consultation_answers: :helpfulnesses).group(:id).order("count(helpfulnesses.id) DESC").limit(10)
      @period = "all"
    else
      @ranks = User.joins(consultation_answers: :helpfulnesses).group(:id).where(helpfulnesses: {created_at: Time.current.all_week}).order("count(helpfulnesses.id) DESC").limit(10)
    end
  end

  def show
    @consultation = Consultation.find(params[:id])
    impressionist(@consultation, nil, unique: [:ip_address]) #IPアドレスでカウント（同投稿に一回のみ）
    @consultation_answer = ConsultationAnswer.new
    @consultation_answers = ConsultationAnswer.where(consultation_id: @consultation.id)
    @warning_id = params[:warning_id]
  end

  def search #キーワード検索からさらにソート可能 listパラメータはタブ切り替え時の判別用
    if params[:keyword]
      if params[:list] == "1" || params[:list] == nil #新着順
        @consultations = Consultation.search(params[:keyword]).order(id: "DESC").page(params[:page]).per(15)
        @list = 1
        @keyword = params[:keyword]
      elsif params[:list] == "2"  #閲覧数順
        @consultations = Consultation.search(params[:keyword]).order(impressions_count: "DESC").page(params[:page]).per(15)
        @list = 2
        @keyword = params[:keyword]
      elsif params[:list] == "3"   #役に立った！が多い順
        @consultations = Consultation.joins(consultation_answers: :helpfulnesses).search(params[:keyword]).group(:consultation_id)
                                     .order("count(helpfulnesses.id) DESC").page(params[:page]).per(15)
        @list = 1
        @keyword = params[:keyword]
      end
    end
    #ページ右側のランキング（相談の回答に”役に立った！”が多い人 週間・月間・全期間）
    if params[:period] == "week"
      @ranks = User.joins(consultation_answers: :helpfulnesses).where(helpfulnesses: {created_at: Time.current.all_week}).group(:id)
                   .order("count(helpfulnesses.id) DESC").limit(10)
      @period = "week"
    elsif params[:period] == "manth"
      @ranks = User.joins(consultation_answers: :helpfulnesses).group(:id).where(helpfulnesses: {created_at: Time.current.all_month}).order("count(helpfulnesses.id) DESC").limit(10)
      @period = "manth"
    elsif params[:period] == "all"
      @ranks = User.joins(consultation_answers: :helpfulnesses).group(:id).order("count(helpfulnesses.id) DESC").limit(10)
      @period = "all"
    else
      @ranks = User.joins(consultation_answers: :helpfulnesses).group(:id).where(helpfulnesses: {created_at: Time.current.all_week}).order("count(helpfulnesses.id) DESC").limit(10)
    end
  end

  def destroy
    @consultation = Consultation.find(params[:id])
    @consultation.destroy
    redirect_to consultations_path
  end

  private
    def consultation_params
      params.require(:consultation).permit(:title, :content, :consultation_image, :genre, :anonymity)
    end

end
