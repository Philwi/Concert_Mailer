class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable
  has_many :user_bands
  has_many :bands, through: :user_bands
  has_many :mailings
  has_many :bookers

  def is_admin?
    self.admin
  end
end
