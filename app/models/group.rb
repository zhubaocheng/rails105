class Group < ApplicationRecord
  #validates :title, :description, presence: ture
  belongs_to :user
  validates_presence_of :title, :description
end
