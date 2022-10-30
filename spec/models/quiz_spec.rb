require 'rails_helper'

describe Quiz do
  describe 'Associations' do
    it { is_expected.to have_many :answers }
    it { is_expected.to belong_to :domain }
  end

  describe 'Validations' do
    it { is_expected.to validate_presence_of(:content) }
  end
end
