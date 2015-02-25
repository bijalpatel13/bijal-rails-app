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

    factory :test_user do
      name "Test User"
      email "test@yahoo.com"
      password_digest { User.digest('password') }
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

  factory :micropost do
    test = User.find_by(email: "bijalpatel@hotmail.com")

    factory :orange do
      content "I just ate an orange!"
      created_at { 10.minutes.ago }
      user test
    end

    factory :tau_manifesto do
      content "Check out the @tauday site"
      created_at { 3.years.ago }
      user test
    end

    factory :cat_video do
      content "Poptart cat: http://youtu.be/QH2-TGUlwu4"
      created_at { 2.hours.ago}
      user test
    end

    factory :most_recent do
      content "This is a test micropost"
      created_at { Time.zone.now }
      user test
    end

    (1..30).each do |i|
      micropost = "micropost_#{i}"
      factory micropost.to_sym do
        content { Faker::Lorem.sentence(5) }
        created_at { 42.days.ago }
        user test
      end
    end

  end
end
