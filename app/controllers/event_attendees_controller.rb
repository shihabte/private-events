class EventAttendeesController < ApplicationController
  before_action :authenticate_user!
  def index
    @event = Event.find(params[:event_id])
    @attendances = EventAttendee.where(event_id: params[:event_id])
  end

  def new
    @attendance = EventAttendee.find_by(user_id: current_user.id)
  end

  def create
    @event = Event.find(params[:event_id])
    if @event.attendees.include?(current_user)
      redirect_to @event, alert: "You are already attending this event."
    else
      @event.attendees << current_user
      redirect_to @event, notice: "Success! You are now attending this event."
    end
  end

  def destroy
    @attendance = EventAttendee.find(params[:id])
    @event = @attendance.event
    if current_user == @attendance.user
      @attendance.destroy
      redirect_to @event, notice: "You are no longer attending this event!"
    else
      redirect_to @event, notice: "You are not authorized to do that!"
    end
  end
end
