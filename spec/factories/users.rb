FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "person#{n}@example.com"
    end
    sequence :first_name do |n|
      "person#{n}@example.com"
    end
    sequence :last_name do |n|
      "person#{n}@example.com"
    end
    password { 'testtest' }
  end
end
