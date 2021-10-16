class ConsultationsController < ApplicationController

  def top
  end

  def new
    @consultation = Consultation.new
    @user = current_user
  end

  def confirm
    @consultation = Consultation.new(consultation_params)
  end

  def create
    @consultation = Consultation.new(consultation_params)
    @consultation.user_id = current_user.id
    @consultation.save!
    redirect_to consultations_path
  end

  def index

    if params[:list] == "1"
      @consultations = Consultation.page(params[:page]).per(8)
      @list = 1
    elsif params[:list] == "2"
      @consultations = Consultation.order(impressions_count: "DESC").page(params[:page]).per(8)
      @list = 2
    elsif params[:list] == "3"
      @consultations = Consultation.joins(consultation_answers: :helpfulnesses).group(:consultation_id).order("count(helpfulnesses.id) DESC").page(params[:page]).per(8)
      @list = 3
    else
      @consultations = Consultation.page(params[:page]).per(8)
    end

  end

  def show
    @consultation = Consultation.find(params[:id])
    impressionist(@consultation, nil, unique: [:user_id]) #ユーザーで判別
    @consultation_answer = ConsultationAnswer.new
    @consultation_answers = ConsultationAnswer.where(consultation_id: @consultation.id)
  end

  def destroy
  end

  private
    def consultation_params
      params.require(:consultation).permit(:title, :content, :consultation_image, :genre, :anonymity)
    end

end
