class MediaWorkoutSet < ApplicationRecord
  belongs_to :video, optional: true
  belongs_to :workout_sets, optional: true
end
