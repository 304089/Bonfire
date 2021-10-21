class HomesController < ApplicationController
  before_action :admin_user, only:[:admin_top]

  def top
  end

end
