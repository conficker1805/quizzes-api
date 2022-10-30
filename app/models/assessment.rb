class Assessment < ApplicationRecord
  extend Enumerize

  store_accessor :expectation
  store_accessor :answers

  NUM_OF_QUESTIONS = 5
  TIME_IN_MINUTES = 5

  enumerize :state, in: %i[processing done expired], default: :processing

  # Callbacks
  before_validation :set_time_allowed

  # Associations
  belongs_to :user
  belongs_to :domain

  # Validations
  validates :expectation, :state, :started_at, :ended_at, presence: true

  private

    def set_time_allowed
      self.started_at = Time.current
      self.ended_at = started_at + TIME_IN_MINUTES.minutes
    end
end
