require 'rails_helper'

RSpec.describe "UsersSignupTest" do

  before :each do
    @count = 0
    ActionMailer::Base.deliveries.clear
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
  
  it "has valid signup information with account activated" do
    get signup_path
    @count = User.count
    post users_path, user: { name: "Example Users",
                             email: "user@example.com",
                             password: "password",
                             password_confirmation: "password" }
    expect(User.count).to eq(@count+1)
    expect(ActionMailer::Base.deliveries.size).to eq(1)
    @user = assigns(:user)
    assert !@user.activated?
    get login_path
    post login_path, session: { email: @user.email, password: "password" }
    assert !is_logged_in?
    get edit_account_activation_path("invalid token")
    assert !is_logged_in?
    get edit_account_activation_path(@user.activation_token, email: 'wrong')
    assert !is_logged_in?
    get edit_account_activation_path(@user.activation_token, email: @user.email)
    assert @user.reload.activated?
    follow_redirect!
    expect(response).to render_template('users/show')
    assert is_logged_in?    
  end
end
