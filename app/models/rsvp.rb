class Rsvp < ApplicationRecord
  belongs_to :attendee, class_name: 'User'
  belongs_to :attended_event, class_name: 'Event'
  validate :attendee_cannot_be_host
  # validate :attendee_cannot_rsvp_twice
  validate :event_cannot_be_in_the_past
  enum invitation: { invited: 0, accepted: 1 }

  def attendee_cannot_be_host
    errors.add(:attendee, 'cannot be host') if attendee == attended_event.creator
  end

  # def attendee_cannot_rsvp_twice
  #   errors.add(:attendee, 'cannot RSVP twice') if attendee.attended_events.include?(attended_event)
  # end

  def event_cannot_be_in_the_past
    errors.add(:event, 'cannot be in the past') if attended_event.event_date < Time.now
  end
end
