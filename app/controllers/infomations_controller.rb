class InfomationsController < ApplicationController
  def new
    @infomation= Infomation.new
  end

  def create
    @infomation= Infomation.new(infomation_params)
    if @infomation.save
      redirect_to thanks_infomations_path
    else
      flash[:infomation_notice] = "全ての項目を正しく入力してください"
      render "new"
    end
  end

  def index
    if params[:genre] == ""
      if params[:sort] == "new"
        @infomations = Infomation.all.order(id: "DESC").page(params[:page]).per(28)
      elsif params[:sort] == "old"
        @infomations = Infomation.page(params[:page]).per(28)
      elsif params[:sort] == "yet"
        @infomations = Infomation.where(status: 0).page(params[:page]).per(28)
      end
    elsif params[:genre] == "0"
      if params[:sort] == "new"
        @infomations = Infomation.where(genre: 0).order(id: "DESC").page(params[:page]).per(28)
      elsif params[:sort] == "old"
        @infomations = Infomation.where(genre: 0).page(params[:page]).per(28)
      elsif params[:sort] == "yet"
        @infomations = Infomation.where(genre: 0, status: 0).page(params[:page]).per(28)
      end
    elsif params[:genre] == "1"
      if params[:sort] == "new"
        @infomations = Infomation.where(genre: 1).order(id: "DESC").page(params[:page]).per(28)
      elsif params[:sort] == "old"
        @infomations = Infomation.where(genre: 1).page(params[:page]).per(28)
      elsif params[:sort] == "yet"
        @infomations = Infomation.where(genre: 1, status: 0).page(params[:page]).per(28)
      end
    elsif params[:genre] == "2"
      if params[:sort] == "new"
        @infomations = Infomation.where(genre: 2).order(id: "DESC").page(params[:page]).per(28)
      elsif params[:sort] == "old"
        @infomations = Infomation.where(genre: 2).page(params[:page]).per(28)
      elsif params[:sort] == "yet"
        @infomations = Infomation.where(genre: 2, status: 0).page(params[:page]).per(28)
      end
    else
      @infomations = Infomation.all.order(id: "DESC").page(params[:page]).per(28)
    end
  end

  def show
    @infomation= Infomation.find(params[:id])
  end

  def update  #管理人が既読、未読のステータス切り替える時
    infomation= Infomation.find(params[:id])
    if params[:status] == "1"
      infomation.update(status: 1)
      redirect_to request.referer
    end
  end

  def thanks  #ありがとページ
  end

  private
  def infomation_params
    params.require(:infomation).permit(:name,:email,:content,:status, :genre)
  end

end
