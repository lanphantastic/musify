class Event < ApplicationRecord
  mount_uploader :image, ImageUploader
  paginates_per 12

  validates :name, presence: true
  # validates :date, presence: true
  validates :venue_id, presence: true

  belongs_to :artist, optional: true
  belongs_to :venue, optional: true
  has_many :images
  has_many :genres, through: :artist
  belongs_to :user, optional: true


  scope :random_event, -> { order("RANDOM()") }


  def pretty_date
    Time.at(self.date).strftime('%A, %B %d, %Y')
  end

  def pretty_time
    Time.at(self.date.to_i).strftime('%I:%M %p')
  end

  private

  def date_cannot_be_in_the_past
    if date != nil || date <= Time.now
      errors.add(:date, "can't be in the past! You silly")
    end
  end

end
