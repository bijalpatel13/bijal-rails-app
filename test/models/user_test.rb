require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  before :each do
    @user = User.new(name: "Bijal Patel", email: "bijalpatel@hotmail.com",
                     password: "password", password_confirmation: "password")
  end

  it "will return fals for a user with nil digest" do
    assert !@user.authenticated?('')
  end
end
