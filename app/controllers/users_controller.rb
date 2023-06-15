class UsersController < ApplicationController
  def show; end

  def show_my_events
    @attended_events = current_user.attended_events
    @past_events = @attended_events.past
    @future_events = @attended_events.future
  end

  def show_my_invitations
    @invitations = current_user.rsvps.invited
    @awaiting_response = @invitations
    @accepted_response = current_user.rsvps.accepted
  end

  def show_my_hosted_events
    @events = current_user.hosted_events
    @past_events = @events.past
    @future_events = @events.future
  end
end
