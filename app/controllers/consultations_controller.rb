class ConsultationsController < ApplicationController

  def index

    @ranks = User.joins(consultation_answers: :helpfulnesses).group(:id).order("count(helpfulnesses.id) DESC").limit(10)

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
      if params[:list] == "1"
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
  end

  def new
    @consultation = Consultation.new
    @user = current_user
  end

  def create
    @consultation = Consultation.new(consultation_params)
    @consultation.user_id = current_user.id
    @consultation.save!
    redirect_to consultations_path
  end

  def show
    @consultation = Consultation.find(params[:id])
    impressionist(@consultation, nil, unique: [:user_id]) #動作確認しやすいためユーザーIDで判別
    @consultation_answer = ConsultationAnswer.new
    @consultation_answers = ConsultationAnswer.where(consultation_id: @consultation.id)
  end

  def search
    @keyword = params[:keyword]

    @ranks = User.joins(consultation_answers: :helpfulnesses).group(:id).order("count(helpfulnesses.id) DESC").limit(10)
    if params[:list] == "1" || params[:list] == nil
      @consultations = Consultation.search(params[:keyword]).order(creared_at: "DESC").page(params[:page]).per(15)
      @list = 1
    elsif params[:list] == "2"
      @consultations = Consultation.search(params[:keyword]).order(impressions_count: "DESC").page(params[:page]).per(15)
      @list = 2
    elsif params[:list] == "3"
      @consultations = Consultation.search(params[:keyword]).joins(consultation_answers: :helpfulnesses).group(:consultation_id)
                                   .order("count(helpfulnesses.id) DESC").page(params[:page]).per(15)
      @list = 3
    else
    end
  end

  def destroy
  end

  private
    def consultation_params
      params.require(:consultation).permit(:title, :content, :consultation_image, :genre, :anonymity)
    end

end
