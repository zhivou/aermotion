class CreateJoinTableUsersWorkoutSets < ActiveRecord::Migration[6.0]
  def change
    create_join_table :users, :workout_sets do |t|
      t.index :user_id
      t.index :workout_set_id
    end
  end
end
