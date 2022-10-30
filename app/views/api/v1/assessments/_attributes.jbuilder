json.set! :attributes do
  json.(resource, :id, :user_id, :domain_id, :state, :started_at, :ended_at)

  json.set! :quizzes do
    json.array! @quizzes do |quiz|
      json.partial! 'api/v1/shared/data_type', resource: quiz
      json.partial! 'api/v1/quizzes/attributes', resource: quiz
    end
  end
end
