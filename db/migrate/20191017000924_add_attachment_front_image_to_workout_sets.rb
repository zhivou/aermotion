class AddAttachmentFrontImageToWorkoutSets < ActiveRecord::Migration[6.0]
  def self.up
    change_table :workout_sets do |t|
      t.attachment :front_image
    end
  end

  def self.down
    remove_attachment :workout_sets, :front_image
  end
end
