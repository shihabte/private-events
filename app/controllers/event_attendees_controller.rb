class EventAttendeesController < ApplicationController
  before_action :authenticate_user!

  def show
    @event_attendee = EventAttendee.new
  end

  def create
    @event = Event.find(params[:event_id])
    user_to_add = User.find_by(email: params[:guest_email])
    if user_to_add.nil?
      redirect_to @event, alert: "A user with that email could not be found."
      return
    end

    if @event.attendees.include?(user_to_add)
      redirect_to @event, alert: "#{user_to_add.name} is already attending this event."
    else
      @event.attendees << user_to_add
      redirect_to @event, notice: "Success! #{user_to_add.name} is now attending this event."
    end
  end

  def destroy
    @attendance = EventAttendee.where(user_id: current_user.id).first
    @event = @attendance.event
    if current_user == @attendance.user
      @attendance.destroy
      redirect_to @event, notice: "You are no longer attending this event!"
    else
      redirect_to @event, notice: "You are not authorized to do that!"
    end
  end
end
