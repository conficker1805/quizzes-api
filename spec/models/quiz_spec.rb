require 'rails_helper'

describe Quiz, type: :model do
  describe 'Associations' do
    it { should have_many :answers }
    it { should belong_to :domain }
  end
end
