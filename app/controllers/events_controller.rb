class EventsController < ApplicationController
  before_action :set_event, only: %i[show edit update destroy invite]
  before_action :authenticate_user!, except: [:index]
  def index
    @events = Event.all
  end

  def new
    @event = Event.new
  end

  def show; end

  def create
    @event = current_user.hosted_events.build(event_params)
    if @event.save
      redirect_to events_path, notice: 'Event was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    return unless current_user != @event.creator

    redirect_to events_path, notice: 'You are not authorized to edit this event.'
  end

  def update
    if @event.update(event_params)
      redirect_to event_path(@event), notice: 'Event was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    if current_user != @event.creator
      redirect_to event_path(@event),
                  notice: 'You are not authorized to delete this event.'
    end
    @event.attendees.delete_all
    @event.destroy
    redirect_to events_path, notice: 'Event was successfully destroyed.', status: :see_other
  end

  def invite
    @users = User.where.not(id: current_user.id)
  end

  # def rsvp
  #   if @event.attendees.include?(current_user)
  #     redirect_to event_path(@event), notice: 'You have already RSVPed to this event.'
  #   else
  #     @event.attendees << current_user
  #     redirect_to event_path(@event)
  #   end
  # end

  # def cancel_rsvp
  #   if @event.attendees.include?(current_user)
  #     @event.attendees.delete(current_user)
  #     redirect_to event_path(@event)
  #   else
  #     redirect_to event_path(@event), notice: 'You have not RSVPed to this event.'
  #   end
  # end

  private

  def set_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:name, :location, :event_date)
  end
end
