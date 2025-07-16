class UsersController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    @user_created_events = @user.created_events.order(id: :desc)
    @previous_events = @user.attended_events.where("event_date < ?", Date.current).order(event_date: :desc)
    @upcoming_events = @user.attended_events.where("event_date >= ?", Date.current).order(:event_date)
  end
end
