class AddTypeToWorkoutSet < ActiveRecord::Migration[6.0]
  def change
    add_reference :workout_sets, :type, null: false, foreign_key: true
  end
end
