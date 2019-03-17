require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Identity' do
    subject { User.new }
    it 'should be an ActiveRecord' do
      expect(subject).to be_a(ActiveRecord::Base)
    end
  end
end
