class HomeController < ApplicationController
  def show
    @developers = Developer
      .visible
      .includes(:role_type).with_attached_avatar
      .available.newest_first
      .limit(10)
    @hired_developers = HiredDeveloper.all
  end
end
