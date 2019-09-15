class AddDescriptionToWorkoutSets < ActiveRecord::Migration[6.0]
  def change
    add_column :workout_sets, :description, :text
  end
end
