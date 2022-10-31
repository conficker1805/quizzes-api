require 'rails_helper'

describe Quizzes::RandomQuery do
  describe '#call' do
    let(:domain) { create(:domain, :with_quizzes) }
    let(:quizzes) { described_class.new(domain).call }

    it 'returns random quizzes' do
      expect(quizzes.size).to eq Assessment::NUM_OF_QUESTIONS
      expect(quizzes.sample.domain).to eq domain
      expect(quizzes.sample.answers).to be_present
    end
  end
end
