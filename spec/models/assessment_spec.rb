require 'rails_helper'

describe Assessment, type: :model do
  describe 'Associations' do
    it { should belong_to :user }
    it { should belong_to :domain }
  end
end
