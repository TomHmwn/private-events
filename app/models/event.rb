class Event < ApplicationRecord
  scope :past, -> { where('event_date < ?', Date.today) }
  scope :future, -> { where('event_date > ?', Date.today) }
  # Ex:- scope :active, -> {where(:active => true)}
  belongs_to :creator, class_name: 'User', foreign_key: 'creator_id'

  has_many :rsvps, foreign_key: :attended_event_id
  has_many :attendees, through: :rsvps, source: :attendee
end
