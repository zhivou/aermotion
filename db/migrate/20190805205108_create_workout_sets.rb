class CreateWorkoutSets < ActiveRecord::Migration[6.0]
  def change
    create_table :workout_sets do |t|
      t.string :title
      t.decimal :price

      t.timestamps
    end
  end
end
