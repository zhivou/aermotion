class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :trackable,
         :timeoutable, :confirmable, :timeout_in => 30.minutes

  has_and_belongs_to_many :workout_sets

  def self.get_sets(user_id)
    user = User.find(user_id)
    user.workout_sets
  end
end