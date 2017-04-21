FactoryGirl.define do
  factory :match do
    date Date.today.strftime("%F")
  end
end
