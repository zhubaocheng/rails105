class Post < ApplicationRecord
  belongs_to :group
  belongs_to :user
  validates_presence_of :content

  scop :recent, -> { order("created_at DESC")}
end
