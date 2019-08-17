class WorkoutSet < ApplicationRecord
  belongs_to :type
  has_and_belongs_to_many :users
  has_and_belongs_to_many :media
  accepts_nested_attributes_for :type, allow_destroy: true
end
