require 'rails_helper'

describe Assessment do
  describe 'Associations' do
    it { is_expected.to belong_to :user }
    it { is_expected.to belong_to :domain }
  end
end
