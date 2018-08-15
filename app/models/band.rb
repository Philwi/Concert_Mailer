class Band < ApplicationRecord
  belongs_to :user
  has_many :event
  validates :name, length: { minimum: 2}
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  before_save :set_color

  private

  def set_color
    if self.event_color.blank?
      self.band_color = "#000"
    end
  end


end
