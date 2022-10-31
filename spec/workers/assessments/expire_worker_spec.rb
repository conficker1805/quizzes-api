require 'rails_helper'

describe Assessments::ExpireWorker do
  describe '#perform' do
    let(:domain) { create(:domain, :with_quizzes) }

    context 'when assessment state is processing (user closes browser)' do
      let(:assessment) do
        create(:assessment, domain: domain, started_at: 20.minutes.ago, ended_at: 15.minutes.ago)
      end

      it 'updates assessment.state to expired' do
        described_class.new.perform(assessment.id)
        expect(assessment.reload.state).to eq 'expired'
      end
    end

    context 'when assessment state is completed (user finished the test)' do
      let(:assessment) do
        create(:assessment, domain: domain, state: :completed)
      end

      it 'does nothing' do
        expect { described_class.new.perform(assessment.id) }.not_to change(assessment, :attributes)
      end
    end
  end
end
