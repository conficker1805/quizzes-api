require 'swagger_helper'

RSpec.describe 'api/v1/assessments' do
  path '/api/v1/assessments' do
    post('Start doing an assessment') do
      response(200, 'OK') do
        consumes 'application/json'

        parameter name: :domain_id,
                  in: :query,
                  type: :integer,
                  description: 'Domain id',
                  required: true

        example 'application/json', 'Return assessment', {
          data: {
            type: 'Assessment',
            attributes: {
              id: 451,
              userId: 1761,
              domainId: 1510,
              state: 'processing',
              startedAt: '2022-10-31T07:36:06.701Z',
              endedAt: '2022-10-31T07:41:06.701Z',
              quizzes: [
                {
                  type: 'Quiz',
                  id: 8755,
                  content: 'Dignissimos corporis iusto. Voluptatem tempore sit.',
                  answers: [
                    { type: 'Answer', id: 35_017, quizId: 8755, content: 'Cupiditate rerum dolore.' },
                    { type: 'Answer', id: 35_018, quizId: 8755, content: 'Vero molestiae dolores iusto.' },
                    { type: 'Answer', id: 35_019, quizId: 8755, content: 'Quia commodi aut illo.' },
                    { type: 'Answer', id: 35_020, quizId: 8755, content: 'Consequuntur voluptates est in.' }
                  ]
                },
                {
                  type: 'Quiz',
                  id: 8759,
                  content: 'Provident eum fuga. Totam similique voluptatem. Nesciunt laborum officiis.',
                  answers: [
                    { type: 'Answer', id: 35_033, quizId: 8759, content: 'Error eaque et esse.' },
                    { type: 'Answer', id: 35_034, quizId: 8759, content: 'Error nesciunt enim voluptate.' },
                    { type: 'Answer', id: 35_035, quizId: 8759, content: 'Beatae enim rerum incidunt.' },
                    { type: 'Answer', id: 35_036, quizId: 8759, content: 'Cumque laudantium iure qui.' }
                  ]
                },
                {
                  type: 'Quiz',
                  id: 8760,
                  content: 'Velit autem aut. Quo consequatur saepe. Tempore odio ut.',
                  answers: [
                    { type: 'Answer', id: 35_037, quizId: 8760, content: 'Qui tenetur provident magnam.' },
                    { type: 'Answer', id: 35_038, quizId: 8760, content: 'Fugit officia atque nemo.' },
                    { type: 'Answer', id: 35_039, quizId: 8760, content: 'Fugiat alias id et.' },
                    { type: 'Answer', id: 35_040, quizId: 8760, content: 'In commodi minima debitis.' }
                  ]
                },
                {
                  type: 'Quiz',
                  id: 8745,
                  content: 'Atque ab voluptatem. Sint non ad. Quos qui aut.',
                  answers: [
                    { type: 'Answer', id: 34_977, quizId: 8745, content: 'Aut in dolor et.' },
                    { type: 'Answer', id: 34_978, quizId: 8745, content: 'Et velit expedita minus.' },
                    { type: 'Answer', id: 34_979, quizId: 8745, content: 'Omnis voluptatem similique.' },
                    { type: 'Answer', id: 34_980, quizId: 8745, content: 'Sed ipsum qui eius.' }
                  ]
                },
                {
                  type: 'Quiz',
                  id: 8752,
                  content: 'Eos animi quia. Ipsam commodi dicta. Minima ipsam occaecati.',
                  answers: [
                    { type: 'Answer', id: 35_005, quizId: 8752, content: 'Maiores nisi quas excepturi.' },
                    { type: 'Answer', id: 35_006, quizId: 8752, content: 'Numquam dignissimos nostrum.' },
                    { type: 'Answer', id: 35_007, quizId: 8752, content: 'Voluptas corporis quibusdam est.' },
                    { type: 'Answer', id: 35_008, quizId: 8752, content: 'Ut dolores aut aut.' }
                  ]
                }
              ]
            }
          }
        }

        run_test!
      end

      response(400, 'Bad request') do
        example 'application/json', 'Domain name is missing', {
          errors: {
            message: 'Bad request. Invalid parameters.'
          }
        }

        run_test!
      end

      response(404, 'Not Found') do
        example 'application/json', 'Domain id is invalid', {
          errors: {
            message: 'Resource not found.'
          }
        }

        run_test!
      end
    end
  end

  path '/api/v1/assessments/{id}' do
    put('Submit answers for an Assessment') do
      consumes 'application/json'

      parameter name: :id, in: :path, type: :string, description: 'Assessment id'
      parameter in: :body, schema: {
                             type: :object,
                             properties: {
                               assessment: { type: :object },
                               properties: {
                                 answers: { type: :object },
                               }
                             },
                             example: {
                               assessment: {
                                 answers: {
                                   '1': [1],
                                   '2': [2],
                                   '3': [3],
                                   '4': [4],
                                   '5': [5],
                                 }
                               }
                             },
                           },
                description: 'A hash of quizzes as keys and answer ids as value'

      response(200, 'OK') do
        example 'application/json', 'Return assessment', {
          data: {
            type: 'Assessment',
            attributes: {
              id: 648,
              userId: 2264,
              domainId: 1941,
              state: 'completed',
              startedAt: '2022-10-31T09:44:10.765Z',
              endedAt: '2022-10-31T09:49:10.765Z',
              expectation: {
                '12326': [49_301],
                '12327': [49_305],
                '12328': [49_309],
                '12332': [49_325],
                '12340': [49_357]
              },
              answers: {
                '12326': [49_301],
                '12327': [49_305],
                '12328': [49_309],
                '12332': [49_325],
                '12340': [49_357]
              },
              score: '5/5',
              quizzes: [
                {
                  type: 'Quiz',
                  id: 12_326,
                  content: 'Qui dolorem deserunt. Asperiores animi sed. Accusantium placeat qui.',
                  answers: [
                    {
                      type: 'Answer',
                      id: 49_301,
                      quizId: 12_326,
                      content: 'Eum sit earum exercitationem.'
                    },
                    {
                      type: 'Answer',
                      id: 49_302,
                      quizId: 12_326,
                      content: 'Reprehenderit et aut nam.'
                    },
                    {
                      type: 'Answer',
                      id: 49_303,
                      quizId: 12_326,
                      content: 'Enim similique est est.'
                    },
                    {
                      type: 'Answer',
                      id: 49_304,
                      quizId: 12_326,
                      content: 'Reiciendis deserunt ipsum harum.'
                    }
                  ]
                },
                {
                  type: 'Quiz',
                  id: 12_327,
                  content: 'Ab sunt quisquam. Consequatur eligendi excepturi. Aut officia voluptatem.',
                  answers: [
                    {
                      type: 'Answer',
                      id: 49_305,
                      quizId: 12_327,
                      content: 'Amet cum molestiae repellat.'
                    },
                    {
                      type: 'Answer',
                      id: 49_306,
                      quizId: 12_327,
                      content: 'Qui natus ut maiores.'
                    },
                    {
                      type: 'Answer',
                      id: 49_307,
                      quizId: 12_327,
                      content: 'Qui cum possimus accusantium.'
                    },
                    {
                      type: 'Answer',
                      id: 49_308,
                      quizId: 12_327,
                      content: 'Cupiditate accusamus harum reprehenderit.'
                    }
                  ]
                },
                {
                  type: 'Quiz',
                  id: 12_328,
                  content: 'Vitae odio natus. Ad nulla autem. Ratione et modi.',
                  answers: [
                    {
                      type: 'Answer',
                      id: 49_309,
                      quizId: 12_328,
                      content: 'Illo nihil unde ipsam.'
                    },
                    {
                      type: 'Answer',
                      id: 49_310,
                      quizId: 12_328,
                      content: 'Neque incidunt nam consectetur.'
                    },
                    {
                      type: 'Answer',
                      id: 49_311,
                      quizId: 12_328,
                      content: 'Dolorum suscipit quasi in.'
                    },
                    {
                      type: 'Answer',
                      id: 49_312,
                      quizId: 12_328,
                      content: 'Facere minima est dolorem.'
                    }
                  ]
                },
                {
                  type: 'Quiz',
                  id: 12_332,
                  content: 'Ducimus saepe molestias. Minus quaerat molestiae. Optio qui minima.',
                  answers: [
                    {
                      type: 'Answer',
                      id: 49_325,
                      quizId: 12_332,
                      content: 'Reiciendis dolorem aspernatur sed.'
                    },
                    {
                      type: 'Answer',
                      id: 49_326,
                      quizId: 12_332,
                      content: 'Libero et in sit.'
                    },
                    {
                      type: 'Answer',
                      id: 49_327,
                      quizId: 12_332,
                      content: 'Debitis voluptates qui corporis.'
                    },
                    {
                      type: 'Answer',
                      id: 49_328,
                      quizId: 12_332,
                      content: 'Illum suscipit voluptatem amet.'
                    }
                  ]
                },
                {
                  type: 'Quiz',
                  id: 12_340,
                  content: 'Et sit ex. Nisi eligendi velit. Mollitia facere qui.',
                  answers: [
                    {
                      type: 'Answer',
                      id: 49_357,
                      quizId: 12_340,
                      content: 'Amet tempore natus maiores.'
                    },
                    {
                      type: 'Answer',
                      id: 49_358,
                      quizId: 12_340,
                      content: 'Incidunt soluta consequatur sint.'
                    },
                    {
                      type: 'Answer',
                      id: 49_359,
                      quizId: 12_340,
                      content: 'Laboriosam quia autem unde.'
                    },
                    {
                      type: 'Answer',
                      id: 49_360,
                      quizId: 12_340,
                      content: 'Officiis occaecati nam voluptates.'
                    }
                  ]
                }
              ]
            }
          }
        }

        run_test!
      end
    end
  end
end
