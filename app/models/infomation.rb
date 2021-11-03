class Infomation < ApplicationRecord
  enum status: {"未読": 0, "既読": 1}
  enum genre: {"広告掲載・取材依頼": 0, "アプリの改善要望": 1, "その他お問い合わせ": 2}
end
