require 'rails_helper'

describe Assessment do
  describe 'Associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :domain }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:expectation) }
    it { is_expected.to validate_presence_of(:state) }
  end

  describe '#auto_expire_after_time' do
    let(:domain) { create(:domain, :with_quizzes) }

    it 'triggers Assessments::ExpireWorker' do
      expect { create(:assessment, domain: domain) }.to change(Assessments::ExpireWorker.jobs, :size).by(1)
    end
  end
end
