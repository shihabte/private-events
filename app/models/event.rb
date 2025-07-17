class Event < ApplicationRecord
  belongs_to :creator, foreign_key: "creator_id", class_name: "User"

  has_many :event_attendees
  has_many :attendees, through: :event_attendees, source: :user, dependent: :destroy

  scope :previous, -> { where("event_date < ?", Date.today) }

  scope :upcoming, -> { where("event_date >= ?", Date.today) }
end
