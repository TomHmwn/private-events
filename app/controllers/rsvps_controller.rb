class RsvpsController < ApplicationController
  def new
    @event = Event.find(params[:event_id])
  end

  def create
    @event = Event.find(params[:event_id])
    # @event.attendees << current_user
    new_rsvp = Rsvp.new(attendee_id: current_user.id, attended_event_id: @event.id)
    if new_rsvp.save
      new_rsvp.invitation_invited!
      flash[:notice] = 'You have successfully RSVPed to this event.'
      redirect_to event_path(@event)
    else
      flash[:alert] = 'Something went wrong. Please try again.'
      redirect_to event_path(@event)
    end
  end

  def destroy
    @event = Event.find(params[:event_id])
    @event.attendees.delete(current_user)
    flash[:notice] = 'You have successfully cancelled your RSVP to this event.'
    redirect_to event_path(@event)
  end

  def accept
    @rsvp = Rsvp.find(params[:id])
    if @rsvp && @rsvp.invited?
      @rsvp.invitation = :accepted
      @rsvp.save!

      flash[:notice] = 'You have successfully accepted this invitation.'
    else
      flash[:alert] = 'Something went wrong. Please try again.'
    end

    redirect_to show_my_invitations_path(current_user)
  end
end
