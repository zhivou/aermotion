class WorkoutSet < ApplicationRecord
  belongs_to :type
  has_and_belongs_to_many :users
  has_and_belongs_to_many :media
  accepts_nested_attributes_for :type, allow_destroy: true

  ##
  # Use this to get all Workouts with users. For admin access only
  # TODO: Start here
  def self.users_and_videos(user_id)
    user = User.find(user_id)

  end
end
