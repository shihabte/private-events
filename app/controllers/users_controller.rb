class UsersController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  def index
    @users = User.all
  end

  def show
    @events = Event.where(creator_id: params[:id]).all
  end
end
