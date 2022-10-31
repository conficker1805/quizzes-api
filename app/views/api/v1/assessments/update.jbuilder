json_data(json) do
  json.partial! 'api/v1/shared/data_type', resource: @assessment
  json.partial! 'api/v1/assessments/attributes',
                resource: @assessment,
                quizzes: @assessment.quizzes,
                show_result: true
end
