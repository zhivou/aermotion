class WorkoutSet < ApplicationRecord
  belongs_to :type
  has_and_belongs_to_many :users
  has_many_attached :videos
  accepts_nested_attributes_for :type, allow_destroy: true
end
