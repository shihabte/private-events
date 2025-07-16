class EventsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  def index
    @previous_events = Event.where("event_date < ?", Date.current)
    @upcoming_events = Event.where("event_date >= ?", Date.current)
  end

  def show
    @event = Event.find(params[:id])
  end

  def new
    @event = Event.new
  end

  def create
    @event = Event.new(event_params)
    @event.creator = current_user

    if @event.save
      redirect_to user_path(current_user)
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])
    if @event.update(event_params)
      redirect_to event_path(@event)
    else
      render :edit
    end
  end

  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to root_path
  end


  private
  def event_params
    params.require(:event).permit(:title, :event_date, :event_location)
  end
end
