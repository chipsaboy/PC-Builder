class User < ActiveRecord::Base
  has_many :builds
  has_many :parts, through: :builds

  has_secure_password
  validates :username, :email, uniqueness: true
  validates :username, :email, presence: true

end
