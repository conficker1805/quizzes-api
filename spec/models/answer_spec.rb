require 'rails_helper'

describe Answer do
  describe 'Associations' do
    it { is_expected.to belong_to :quiz }
  end
end
