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

  def index
    if params[:genre] == "0"
      @genre = 0
      if params[:list] == "1"
        @consultations = Consultation.where(genre: "キャンプ場").order(created_at: "DESC").page(params[:page]).per(15)
        @list = 1
      elsif params[:list] == "2"
        @consultations = Consultation.where(genre: "キャンプ場").order(impressions_count: "DESC").page(params[:page]).per(15)
        @list = 2
      elsif params[:list] == "3"
        @consultations = Consultation.joins(consultation_answers: :helpfulnesses).group(:consultation_id)
                                     .where(genre: "キャンプ場").order("count(helpfulnesses.id) DESC").page(params[:page]).per(15)
        @list = 3
      else
        @consultations = Consultation.where(genre: "キャンプ場").order(created_at: "DESC").page(params[:page]).per(15)
      end
    elsif params[:genre] == "1"
      @genre = 1
      if params[:list] == "1"
        @consultations = Consultation.where(genre: "キャンプ道具").order(created_at: "DESC").page(params[:page]).per(15)
        @list = 1
      elsif params[:list] == "2"
        @consultations = Consultation.where(genre: "キャンプ道具").order(impressions_count: "DESC").page(params[:page]).per(15)
        @list = 2
      elsif params[:list] == "3"
        @consultations = Consultation.joins(consultation_answers: :helpfulnesses).group(:consultation_id)
                                     .where(genre: "キャンプ道具").order("count(helpfulnesses.id) DESC").page(params[:page]).per(15)
        @list = 3
      else
        @consultations = Consultation.where(genre: "キャンプ道具").order(created_at: "DESC").page(params[:page]).per(15)
      end
    elsif params[:genre] == "2"
      @genre = 2
      if params[:list] == "1"
        @consultations = Consultation.where(genre: "キャンプ料理").order(created_at: "DESC").page(params[:page]).per(15)
        @list = 1
      elsif params[:list] == "2"
        @consultations = Consultation.where(genre: "キャンプ料理").order(impressions_count: "DESC").page(params[:page]).per(15)
        @list = 2
      elsif params[:list] == "3"
        @consultations = Consultation.joins(consultation_answers: :helpfulnesses).group(:consultation_id)
                                     .where(genre: "キャンプ料理").order("count(helpfulnesses.id) DESC").page(params[:page]).per(15)
        @list = 3
      else
        @consultations = Consultation.where(genre: "キャンプ料理").order(created_at: "DESC").page(params[:page]).per(15)
      end
    elsif params[:genre] == "3"
      @genre = 3
      if params[:list] == "1"
        @consultations = Consultation.where(genre: "その他").order(created_at: "DESC").page(params[:page]).per(15)
        @list = 1
      elsif params[:list] == "2"
        @consultations = Consultation.where(genre: "その他").order(impressions_count: "DESC").page(params[:page]).per(15)
        @list = 2
      elsif params[:list] == "3"
        @consultations = Consultation.joins(consultation_answers: :helpfulnesses).group(:consultation_id)
                                     .where(genre: "その他").order("count(helpfulnesses.id) DESC").page(params[:page]).per(15)
        @list = 3
      else
        @consultations = Consultation.where(genre: "その他").order(created_at: "DESC").page(params[:page]).per(15)
      end
    else
      if params[:user_id]
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
        @list = 0
      elsif params[:list] == "1"
        @consultations = Consultation.order(created_at: "DESC").page(params[:page]).per(15)
        @list = 1
      elsif params[:list] == "2"
        @consultations = Consultation.order(impressions_count: "DESC").page(params[:page]).per(15)
        @list = 2
      elsif params[:list] == "3"
        @consultations = Consultation.joins(consultation_answers: :helpfulnesses).group(:consultation_id)
                                     .order("count(helpfulnesses.id) DESC").page(params[:page]).per(15)
        @list = 3
      else
        @consultations = Consultation.order(created_at: "DESC").page(params[:page]).per(15)
      end
    end

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
    impressionist(@consultation, nil, unique: [:user_id]) #動作確認しやすいためユーザーIDで判別
    @consultation_answer = ConsultationAnswer.new
    @consultation_answers = ConsultationAnswer.where(consultation_id: @consultation.id)
  end

  def search
    if params[:keyword]
      if params[:list] == "1" || params[:list] == nil
        @consultations = Consultation.search(params[:keyword]).order(id: "DESC").page(params[:page]).per(15)
        @list = 1
      elsif params[:list] == "2"
        @consultations = Consultation.search(params[:keyword]).order(impressions_count: "DESC").page(params[:page]).per(15)
        @list = 2
      elsif params[:list] == "3"
        @consultations = Consultation.joins(consultation_answers: :helpfulnesses).search(params[:keyword]).group(:consultation_id)
                                     .order("count(helpfulnesses.id) DESC").page(params[:page]).per(15)
        @list = 3
      end
    end

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
      params.require(:consultation).permit(:title, :content, :consultation_image, :genre, :anonymity, :sort, :period)
    end

end
