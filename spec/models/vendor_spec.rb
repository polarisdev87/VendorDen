require 'rails_helper'

RSpec.describe Vendor, type: :model do

  describe 'Identity' do
    subject { Vendor.new }
    it 'should be an ActiveRecord' do
      expect(subject).to be_a(ActiveRecord::Base)
    end
  end
end
