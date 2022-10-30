module Quizzes
  class RightAnswerService
    def initialize(quizzes)
      @quizzes = quizzes
    end

    # This function map questions and its answers to a collection of hash
    # Format: { question_id => [correct_answer_ids], ... }
    # Output: {1=>[1, 2], 2=>[6]}.
    def call
      hash = {}
      @quizzes.sort.map do |quiz|
        hash[quiz.id] = quiz.answers.select { |a| a.correct == true }.map(&:id)
      end

      hash
    end
  end
end
