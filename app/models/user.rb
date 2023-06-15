class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :hosted_events, foreign_key: :creator_id, class_name: 'Event'
  has_many :rsvps, foreign_key: :attendee_id, dependent: :destroy
  has_many :attended_events, through: :rsvps
end
