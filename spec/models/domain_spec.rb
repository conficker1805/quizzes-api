require 'rails_helper'

describe Domain do
  describe 'Associations' do
    it { is_expected.to have_many :quizzes }
  end
end
