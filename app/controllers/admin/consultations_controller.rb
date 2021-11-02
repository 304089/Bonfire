class Admin::ConsultationsController < ApplicationController
  before_action :admin_user

  def index
    if params[:sort] == "new" || params[:sort] == nil                                   #新しい順
      @consultations = Consultation.all.page(params[:page]).per(30)
    elsif params[:sort] == "old"                                                        #古い順
      @consultations = Consultation.order(id: "DESC").page(params[:page]).per(30)
    elsif params[:sort] == "look"                                                     #閲覧数多い順
      @consultations = Consultation.order(impressions_count: "DESC").page(params[:page]).per(30)
    elsif params[:sort] == "comment"                                                     #コメント多い順
      @consultations = Consultation.joins(:consultation_answers).group(:id).order("count(consultation_answers.id)DESC").page(params[:page]).per(30)
    elsif params[:sort] == "helpfulness"                                                     #役に立った！多い順
      @consultations = Consultation.joins(consultation_answers: :helpfulnesses).group(:id)
                                   .order("count(helpfulnesses.id) DESC").page(params[:page]).per(30)
    end
    @warning = []
    @consultations.each do |consultation|
      @warning << consultation.consultation_answers.select{ |value| value[:score].to_f <= -0.5 } #感情分析結果、スコアが-0.5以下のコメントを抽出
    end
  end

  def search
    @consultations = Consultation.search(params[:keyword]).group(:id).page(params[:page]).per(30)
    @keyword = params[:keyword]
  end

end
