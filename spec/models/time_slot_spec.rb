require 'rails_helper'

RSpec.describe TimeSlot, type: :model do

  before do
    @current_shop = create(:shop)
  end

  describe 'Identity' do
    subject { TimeSlot.new }
    it 'should be an ActiveRecord' do
      expect(subject).to be_a(ActiveRecord::Base)
    end
  end

  context "default values" do

    describe "#start_date default values" do

      it "should be the current date" do
        expect(subject.start_date).to eq(Time.zone.now.strftime('%Y-%m-%d'))
      end
    end

    describe "#start_time default values" do

      it "should be at 8:00 AM" do
        expect(subject.start_time).to eq('08:00')
      end
    end

    describe "#end_date default values" do

      it "should be the current date" do
        expect(subject.end_date).to eq(Time.zone.now.strftime('%Y-%m-%d'))
      end
    end

    describe "#end_time default values" do

      it "should be at 5:00 PM" do
        expect(subject.end_time).to eq('17:00')
      end
    end
  end

  context "validations" do

    before do
      @existing_time_slot = @current_shop.time_slots.create!(description: "Existing TimeSlot", is_all_day: false)
    end

    describe "when there is an existing time slot with the same date range" do
      subject do
        @current_shop.time_slots.build(description: "TimeSlot #1")
      end
      it 'makes the new one invalid' do
        expect(subject).to_not be_valid
      end
    end

    describe "when #start_at > #end_at" do
      subject do
        start_at = 5.days.from_now
        end_at = Time.zone.now
        @current_shop.time_slots.build(description: "TimeSlot #1", start_at: start_at, end_at: end_at)
      end
      it 'is invalid' do
        expect(subject).to_not be_valid
      end
    end

    describe "when it overlaps at the top of an existing time slot" do
      subject do
        start_at = @existing_time_slot.start_at - 1.hour
        end_at = @existing_time_slot.end_at - 1.hour
        @current_shop.time_slots.build(description: "TimeSlot #1", start_at: start_at, end_at: end_at)
      end
      it 'is invalid' do
        expect(subject).to_not be_valid
      end
    end

    describe "when it overlaps at the bottom of an existing time slot" do
      subject do
        start_at = @existing_time_slot.start_at + 1.hour
        end_at = @existing_time_slot.end_at + 1.hour
        @current_shop.time_slots.build(description: "TimeSlot #1", start_at: start_at, end_at: end_at)
      end
      it 'is invalid' do
        expect(subject).to_not be_valid
      end
    end

    describe "when it is shorter than an existing time slot but with same #start_at" do
      subject do
        start_at = @existing_time_slot.start_at
        end_at = @existing_time_slot.end_at - 1.hour
        @current_shop.time_slots.build(description: "TimeSlot #1", start_at: start_at, end_at: end_at)
      end
      it 'is invalid' do
        expect(subject).to_not be_valid
      end
    end

    describe "when it is shorter than an existing time slot but with same #end_at" do
      subject do
        start_at = @existing_time_slot.start_at - 1.hour
        end_at = @existing_time_slot.end_at 
        @current_shop.time_slots.build(description: "TimeSlot #1", start_at: start_at, end_at: end_at)
      end
      it 'is invalid' do
        expect(subject).to_not be_valid
      end
    end

    describe "when it is longer than an existing time slot but with same #start_at" do
      subject do
        start_at = @existing_time_slot.start_at
        end_at = @existing_time_slot.end_at + 1.hour
        @current_shop.time_slots.build(description: "TimeSlot #1", start_at: start_at, end_at: end_at)
      end
      it 'is invalid' do
        expect(subject).to_not be_valid
      end
    end

    describe "when it is longer than an existing time slot but with same #end_at" do
      subject do
        start_at = @existing_time_slot.start_at + 1.hour
        end_at = @existing_time_slot.end_at
        @current_shop.time_slots.build(description: "TimeSlot #1", start_at: start_at, end_at: end_at)
      end
      it 'is invalid' do
        expect(subject).to_not be_valid
      end
    end

    describe "when it covers an existing time slot" do
      subject do
        start_at = @existing_time_slot.start_at - 1.hour
        end_at = @existing_time_slot.end_at + 1.hour
        @current_shop.time_slots.build(description: "TimeSlot #1", start_at: start_at, end_at: end_at)
      end
      it 'is invalid' do
        expect(subject).to_not be_valid
      end
    end

    describe "when it is inside an time slot" do
      subject do
        start_at = @existing_time_slot.start_at + 1.hour
        end_at = @existing_time_slot.end_at - 1.hour
        @current_shop.time_slots.build(description: "TimeSlot #1", start_at: start_at, end_at: end_at)
      end
      it 'is invalid' do
        expect(subject).to_not be_valid
      end
    end
  end
end
