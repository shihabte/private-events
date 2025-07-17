class Event < ApplicationRecord
  belongs_to :creator, foreign_key: "creator_id", class_name: "User"

  has_many :event_attendees
  has_many :attendees, through: :event_attendees, source: :user, dependent: :destroy

  def self.previous
    self.where("event_date < ?", Date.today)
  end

  def self.upcoming
    self.where("event_date >= ?", Date.today)
  end
end
