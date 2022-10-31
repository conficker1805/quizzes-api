class Assessment < ApplicationRecord
  include AASM

  # Number of quizzes in assessment
  NUM_OF_QUESTIONS = 5

  # Time to finish the assessment
  TIME_IN_MINUTES = 5

  serialize :expectation, ActiveRecord::Coders::NestedHstore
  serialize :answers, ActiveRecord::Coders::NestedHstore

  # Callbacks
  before_validation :set_time_allowed, on: :create
  before_validation :format_answers, on: :update
  after_create :auto_expire_after_time

  # Associations
  belongs_to :user
  belongs_to :domain

  # Validations
  validates :expectation, :state, :started_at, :ended_at, presence: true
  validates :user_id, uniqueness: { scope: :state }, if: -> { processing? }
  validate :valid_user_answers, on: :update

  # State machine
  aasm column: :state do
    state :processing, initial: true
    state :completed, :expired

    event :complete do
      transitions from: :processing, to: :completed
    end

    event :expire do
      transitions from: :processing, to: :expired
    end
  end

  def quizzes
    Quiz.where(id: expectation.keys.map(&:to_i))
  end

  private

    def set_time_allowed
      self.started_at = Time.current
      self.ended_at = started_at + TIME_IN_MINUTES.minutes
    end

    def format_answers
      self.answers = answers.transform_values! { |v| v.map(&:to_i) }
    end

    def valid_user_answers
      # If user's answers do not match given questions
      union_answers = (expectation.keys | answers.keys)

      return if expectation.keys.sort == union_answers.sort

      errors.add(:answers, :answers_are_invalid)
    end

    def auto_expire_after_time
      # User may close the browse and does not submit their answer
      # so we have to check and expire it at ended_time + 1 minutes
      num_of_minutes = (TIME_IN_MINUTES + 1).minutes
      Assessments::ExpireWorker.perform_in(num_of_minutes)
    end
end
