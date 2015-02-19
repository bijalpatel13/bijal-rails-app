FactoryGirl.define do
  factory :user do
    name "Bijal Patel"
    email "bijalpatel@hotmail.com"
    password_digest User.digest('password')
  end
end
