class Build < ActiveRecord::Base
  belongs_to :user
  has_many :parts

  validates_presence_of :title, :budget
end
