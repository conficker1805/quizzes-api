require 'rails_helper'

describe Answer, type: :model do
  describe 'Associations' do
    it { should belong_to :quiz }
  end
end
