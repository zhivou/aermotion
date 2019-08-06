class CreateUsersSetConnector < ActiveRecord::Migration[6.0]
  def change
    create_table :users_set_connectors do |t|
      t.references :users, index: true, foreign_key: true
      t.references :workout_sets, index: true, foreign_key: true
    end
  end
end
