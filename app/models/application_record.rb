class ApplicationRecord < ActiveRecord::Base
  self.abstract_class = true

  def active_user?
    self.status == "管理者" || self.status == "会員"
  end

  def admin?
    self.status == "管理者"
  end
end