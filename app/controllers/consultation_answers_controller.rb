class ConsultationAnswersController < ApplicationController
  before_action :active_user

  def create
    @consultation = Consultation.find(params[:consultation_id])
    @consultation_answers = ConsultationAnswer.where(consultation_id: @consultation.id)
    @consultation_answer = ConsultationAnswer.new(consultation_answer_params)
    @consultation_answer.score = Language.get_data(consultation_answer_params[:answer])
    @consultation_answer.user_id = current_user.id
    @consultation_answer.consultation_id = @consultation.id
    if @consultation_answer.save
      if @consultation_answer.score <= -0.5
        flash.now[:alert] = "この回答には不適切な表現が含まれている可能性があります。<br>場合によっては管理者が削除することがあります。".html_safe
      end
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
