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
end
