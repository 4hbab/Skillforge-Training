class Course < ApplicationRecord
  belongs_to :category
  belongs_to :instructor, class_name: 'User'

  validates :title, presence: true
  validates :description, presence: true
  validates :difficulty, presence: true, inclusion: { in: %w[beginner intermediate advanced] }
end
