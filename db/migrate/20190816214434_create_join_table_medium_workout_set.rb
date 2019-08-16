class CreateJoinTableMediumWorkoutSet < ActiveRecord::Migration[6.0]
  def change
    create_join_table :media, :workout_sets do |t|
      t.index :medium_id
      t.index :workout_set_id
    end
  end
end
