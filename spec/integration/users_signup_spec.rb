require 'rails_helper'

RSpec.describe "UsersSignupTest" do

  before :each do
    @count = 0
  end

  it "has invalid signup information" do
    get signup_path
    @count = User.count
    post users_path, user: { name: "",
                             email: "user@invalid",
                             password: "foo",
                             password_confirmation: "bar" }
    expect(User.count).to eq(@count) 
    expect(response).to render_template('users/new')
  end
  
  it "has valid signup information" do
    get signup_path
    @count = User.count
    post users_path, user: { name: "Example Users",
                             email: "user@example.com",
                             password: "password",
                             password_confirmation: "password" }
    expect(User.count).to eq(@count+1) 
  end
end
