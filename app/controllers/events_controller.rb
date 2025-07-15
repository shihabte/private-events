class EventsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  def index
    @events = Event.all
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.creator_id = current_user.id

    if @event.save
      redirect_to root_path
    else
      render :new, status: :unprocessable_entity
    end
  end


  private
  def event_params
    params.require(:event).permit(:title, :event_date, :event_location)
  end
end
