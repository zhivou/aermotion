class WorkoutSet < ApplicationRecord
  belongs_to :type
  has_and_belongs_to_many :users
  has_and_belongs_to_many :media
  accepts_nested_attributes_for :type, allow_destroy: true
  has_one_attached :main_image

  def self.get_by_type(type_name)
    where(type: Type.where(name: type_name))
  end

  def self.exclude_current_user(user)
    where.not(id: user.workout_sets.includes(:type).each {|i| i})
  end
end
