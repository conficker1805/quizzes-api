json_template(json, @assessment) do
  json.partial! 'api/v1/shared/data_type', resource: @assessment
  json.partial! 'api/v1/assessments/attributes', resource: @assessment, quizzes: @quizzes
end
