class Domain < ApplicationRecord
  extend FriendlyId
  extend Enumerize

  friendly_id :name, use: :slugged

  # Associations
  has_many :quizzes, dependent: :destroy
end
