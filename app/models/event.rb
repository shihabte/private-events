class Event < ApplicationRecord
  belongs_to :creator, class_name: "User"
  has_many :attendees, foreign_key: "event_id", class_name: "Event"
end
