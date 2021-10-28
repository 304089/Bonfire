class ConsultationAnswersController < ApplicationController
  before_action :active_user

  def create
    @consultation = Consultation.find(params[:consultation_id])
    @consultation_answers = ConsultationAnswer.where(consultation_id: @consultation.id)
    @consultation_answer = ConsultationAnswer.new(consultation_answer_params)
    @consultation_answer.user_id = current_user.id
    @consultation_answer.consultation_id = @consultation.id
    if @consultation_answer.save
      render :answers
    else
      render :answers
    end
  end

  def destroy
    @consultation = Consultation.find(params[:consultation_id])
    @consultation_answers = ConsultationAnswer.where(consultation_id: @consultation.id)
    @consultation_answer = ConsultationAnswer.find(params[:id])
    @consultation_answer.destroy
    render :answers
  end

  private
    def consultation_answer_params
      params.require(:consultation_answer).permit(:answer, :answer_image)
    end

end
