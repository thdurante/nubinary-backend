module Calculators
  class StringCalculator < BaseCalculator
    def initialize; end

    def non_continuous_substring?(source_str, comparing_str)
      return unless source_str.is_a?(String) && comparing_str.is_a?(String)

      calculate_result(source_str, comparing_str)
    end

    private

    def calculate_result(source_str, comparing_str)
      result = true

      comparing_str.chars.each do |comparing_char|
        matching_index = source_str.index(comparing_char)

        if matching_index
          source_str = source_str[matching_index + 1..-1]
        else
          result = false
          break
        end
      end

      result
    end
  end
end
