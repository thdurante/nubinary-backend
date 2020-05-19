require 'rails_helper'

RSpec.describe StringCalculation, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to(:user).optional(false) }
  end

  describe 'validations' do
    it { is_expected.to validate_presence_of(:source_str) }
    it { is_expected.to validate_presence_of(:comparing_str) }
  end

  describe 'callbacks' do
    describe 'after_validation :check_matching_substring' do
      context 'when new record' do
        it 'fills the :matching attribute' do
          string_calculation = build(:string_calculation, source_str: 'abcdef', comparing_str: 'bdf')
          expect { string_calculation.valid? }.to change(string_calculation, :matching).from(nil).to(true)
        end
      end

      context 'when existing record' do
        it 'updates the :matching attribute' do
          string_calculation = create(:string_calculation, source_str: 'abcdef', comparing_str: 'bdf')
          string_calculation.assign_attributes(comparing_str: 'bb')

          expect { string_calculation.valid? }.to change(string_calculation, :matching).from(true).to(false)
        end
      end
    end
  end
end
