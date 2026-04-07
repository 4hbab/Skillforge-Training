class User < ApplicationRecord
  # Devise authentication modules
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # Enum defines named roles mapping to the integer column
  enum :role, { learner: 0, instructor: 1, admin: 2 }

  # Validations to ensure data integrity
  validates :name, presence: true
  validates :email, presence: true
end