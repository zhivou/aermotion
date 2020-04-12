class CreateSiteSettings < ActiveRecord::Migration[6.0]
  def change
    create_table :site_configurations do |t|
      t.string  :key
      t.text    :value

      t.timestamps
    end

    add_index :site_configurations, :key, unique: true
  end
end
