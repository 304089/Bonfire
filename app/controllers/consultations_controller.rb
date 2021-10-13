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
    @consultations = Consultation.page(params[:page]).per(8)
  end

  def show
    @consultation = Consultation.find(params[:id])
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
