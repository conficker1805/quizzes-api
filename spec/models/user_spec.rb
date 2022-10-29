require 'rails_helper'

describe User do
  describe 'Associations' do
    it { is_expected.to have_many :assessments }
  end
end
