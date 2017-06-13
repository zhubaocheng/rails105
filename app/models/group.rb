class Group < ApplicationRecord
  #validates :title, :description, presence: ture
  has_many :posts
  belongs_to :user
  validates_presence_of :title, :description
  has_many :group_relationships
  has_many :members, through: :group_relationships, source: :user
end
