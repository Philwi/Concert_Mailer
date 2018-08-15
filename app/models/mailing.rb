class Mailing < ApplicationRecord
  belongs_to :user
  validates :body, presence: true
  validates :subject, presence: true
end
