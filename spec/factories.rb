FactoryGirl.define do
  factory :user do

    factory :bijal do
      name "Bijal Patel"
      email "bijalpatel@hotmail.com"
      password_digest { User.digest('password') }
      admin true
      activated true
      activated_at { Time.zone.now }
    end

    factory :example do
      name "Example User"
      email "example@railstutorial.org"
      password_digest { User.digest('foobar') }
      activated true
      activated_at { Time.zone.now }
    end

    (1..40).each do |i|
      username = "user_#{i}"

      factory username.to_sym do
        name "User #{i}"
        email "user-#{i}@example.com"
        password_digest { User.digest('password') }
        activated true
        activated_at { Time.zone.now }
      end
    end
    
  end
end
