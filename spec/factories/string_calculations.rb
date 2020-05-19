FactoryBot.define do
  factory :string_calculation do
    association(:user)
    source_str { 'string' }
    comparing_str { 'str' }
    matching { nil }
  end
end
