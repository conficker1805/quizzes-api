class Quiz < ApplicationRecord
  # Associations
  has_many :answers, dependent: :destroy
  belongs_to :domain

  # Validations
  validates :content, presence: true
end
