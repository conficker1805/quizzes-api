class Quiz < ApplicationRecord
  # Associations
  has_many :answers, dependent: :destroy
  belongs_to :domain
end
