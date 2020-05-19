require 'rails_helper'

RSpec.describe Calculators::StringCalculator do
  describe '#non_continuous_substring?' do
    it do
      expect(
        described_class.new.non_continuous_substring?('abcdefg', 'beg')
      ).to be_truthy
    end

    it do
      expect(
        described_class.new.non_continuous_substring?('abcadebabdeb', 'baabd')
      ).to be_truthy
    end

    it do
      expect(
        described_class.new.non_continuous_substring?('abcadebabdeb', 'baabbd')
      ).to be_falsey
    end
  end
end
