class Consultation < ApplicationRecord

  with_options presence: true do
    validates :genre
    validates :title
    validates :content, length: { in: 1..1000 }
  end

  attachment :consultation_image
  has_many :consultation_answers, dependent: :destroy
  has_many :helpfulnesses, through: :consultation_answers, dependent: :destroy
  belongs_to :user

  enum status: {"未解決": 0, "解決": 1}
  enum genre: {"キャンプ場": 0, "キャンプ道具": 1, "キャンプ料理": 2, "その他": 3}

  is_impressionable counter_cache: true #相談の閲覧数計測用

  def set_date
    created_at.strftime("%Y年%m月%d日 %H:%M")
  end

  def self.search(keyword)
    if keyword == "" #未入力の場合は全件表示
      Consultation.all
    else  #相談タイトル、内容、回答の部分一致検索
      Consultation.joins(:consultation_answers).where(['title like? OR content like? OR consultation_answers.answer like?', "%#{keyword}%", "%#{keyword}%", "%#{keyword}%"])
    end
  end

end
