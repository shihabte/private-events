class UsersController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @previous_events = @user.attended_events.where("event_date < ?", Date.current)
    @upcoming_events = @user.attended_events.where("event_date >= ?", Date.current)
  end
end
