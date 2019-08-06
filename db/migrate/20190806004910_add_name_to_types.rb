class AddNameToTypes < ActiveRecord::Migration[6.0]
  def change
    add_column :types, :name, :string
  end
end
