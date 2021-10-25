class HelpfulnessesController < ApplicationController
  before_action :active_user

  def create
    @consultation_answer = ConsultationAnswer.find(params[:consultation_answer_id])
    helpfulness = current_user.helpfulnesses.new(consultation_answer_id: @consultation_answer.id)
    helpfulness.save
  end

  def destroy
    @consultation_answer = ConsultationAnswer.find(params[:consultation_answer_id])
    helpfulness = current_user.helpfulnesses.find_by(consultation_answer_id: @consultation_answer.id)
    helpfulness.destroy
  end

end
