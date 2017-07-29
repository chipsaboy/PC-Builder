class Part < ActiveRecord::Base
  belongs_to :build

  validates_presence_of :name, :price
end
