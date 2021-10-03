class Infomation < ApplicationRecord
  enum status: {"未回答": 0, "回答済み": 1}, _prefix: true
end
