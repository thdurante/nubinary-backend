class StringCalculation < ApplicationRecord
  belongs_to :user, optional: false

  validates :source_str, presence: true
  validates :comparing_str, presence: true

  after_validation :check_matching_substring

  private

  def check_matching_substring
    self.matching =
      Calculators::StringCalculator.new.non_continuous_substring?(source_str, comparing_str)
  end
end
