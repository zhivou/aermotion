class UsersWorkoutSet < ApplicationRecord
  belongs_to :user, optional: true
  belongs_to :workout_sets, optional: true
end
