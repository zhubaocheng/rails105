class Group < ApplicationRecord
  #validates :title, :description, presence: ture
  has_many :posts
  belongs_to :user
  validates_presence_of :title, :description
end
