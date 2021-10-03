class HelpfulnessesController < ApplicationController
  def create
    consultation_answer = ConsultationAnswer.find(params[:consultation_answer_id])
    helpfulness = current_user.helpfulnesses.new(consultation_answer_id: consultation_answer.id)
    helpfulness.save
    redirect_to request.referer
  end

  def destroy
    consultation_answer = ConsultationAnswer.find(params[:consultation_answer_id])
    helpfulness = current_user.helpfulnesses.find_by(consultation_answer_id: consultation_answer.id)
    helpfulness.destroy
    redirect_to request.referer
  end

end
