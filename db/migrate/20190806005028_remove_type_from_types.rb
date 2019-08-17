class RemoveTypeFromTypes < ActiveRecord::Migration[6.0]
  def change
    remove_column :types, :type, :string
  end
end
