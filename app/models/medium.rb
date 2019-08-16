class Medium < ApplicationRecord
  has_one_attached :video
  has_and_belongs_to_many :workout_sets
end
