class Group < ApplicationRecord
  #validates :title, :description, presence: ture
  validates_presence_of :title, :description
end
