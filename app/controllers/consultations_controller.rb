class ConsultationsController < ApplicationController

  def top
  end

  def new
    @consultation = Consultation.new
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
    @consultations = Consultation.all
  end

  def show
  end

  def destroy
  end

  private
    def consultation_params
      params.require(:consultation).permit(:title, :content, :consultation_image, :consultation_genre_id)
    end

end
