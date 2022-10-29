require 'rails_helper'

describe Domain, type: :model do
  describe 'Associations' do
    it { should have_many :quizzes }
  end
end
