require 'rails_helper'

RSpec.describe VendorInvite, type: :model do

  describe 'Identity' do
    subject { VendorInvite.new }
    it 'should be an ActiveRecord' do
      expect(subject).to be_a(ActiveRecord::Base)
    end
  end
end
