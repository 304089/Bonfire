class ConsultationAnswersController < ApplicationController

  def create
    consultation = Consultation.find(params[:consultation_id])
    @consultation_answer = ConsultationAnswer.new(consultation_answer_params)
    @consultation_answer.user_id = current_user.id
    @consultation_answer.consultation_id = consultation.id
    @consultation_answer.save!
    redirect_to request.referer
  end

  def destroy
  end

  private
    def consultation_answer_params
      params.require(:consultation_answer).permit(:answer, :answer_image)
    end
end
