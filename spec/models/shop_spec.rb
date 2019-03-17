require 'rails_helper'

RSpec.describe Shop, type: :model do

  describe 'Identity' do
    subject { Shop.new }
    it 'should be an ActiveRecord' do
      expect(subject).to be_a(ActiveRecord::Base)
    end
  end
end
