FactoryGirl.define do
  factory :user do

    factory :bijal do
      name "Bijal Patel"
      email "bijalpatel@hotmail.com"
      password_digest { User.digest('password') }
    end

    factory :example do
      name "Example User"
      email "example@railstutorial.org"
      password_digest { User.digest('foobar') }
    end

    (1..40).each do |i|
      username = "user_#{i}"

      factory username.to_sym do
        name "User #{i}"
        email "user-#{i}@example.com"
        password_digest { User.digest('password') }
      end
    end
    
  end
end
