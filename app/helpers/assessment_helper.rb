module AssessmentHelper
  def calculate_score(assessment)
    wrong_answers = hash_diff(assessment.expectation, assessment.answers)
    correct_count = assessment.expectation.size - wrong_answers.size
    total_count   = assessment.expectation.size

    "#{correct_count}/#{total_count}"
  end

  # Mirror of https://apidock.com/rails/Hash/diff (deprecated)
  def hash_diff(first, second)
    first
      .dup
      .delete_if { |k, v| second[k] == v }
      .merge!(second.dup.delete_if { |k, _v| first.key?(k) })
  end
end
