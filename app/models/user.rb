class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: true, presence: true
  validates :role, presence: true
  validates :password, presence: true

  has_many :favorites
  has_many :books, through: :favorites

  def admin?
    self.role.eql? 'admin'
  end
end
