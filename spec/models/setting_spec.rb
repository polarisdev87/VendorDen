require 'rails_helper'

RSpec.describe Setting, type: :model do

  describe 'Identity' do
    subject { Setting.new }
    it 'should be an ActiveRecord' do
      expect(subject).to be_a(ActiveRecord::Base)
    end
  end
end
