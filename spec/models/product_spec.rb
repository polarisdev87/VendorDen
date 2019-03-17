require 'rails_helper'

RSpec.describe Product, type: :model do

  describe 'Identity' do
    subject { Product.new }
    it 'should be an ActiveRecord' do
      expect(subject).to be_a(ActiveRecord::Base)
    end
  end
end
