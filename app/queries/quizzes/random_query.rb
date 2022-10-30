module Quizzes
  class RandomQuery
    def initialize(domain)
      @domain = domain
    end

    def call
      Quiz.includes(:answers)
          .where(domain: @domain)
          .limit(Assessment::NUM_OF_QUESTIONS)
          .order('RANDOM()')
    end
  end
end
