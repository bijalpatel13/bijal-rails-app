require 'rails_helper'
require 'spec_helper'

RSpec.describe UsersController, :type => :controller do

  before :each do
    @user = User.find_by(email: "bijalpatel@hotmail.com")
    @other_user = User.find_by(email: "example@railstutorial.org")
    @count = 0
  end

  it "should redirect index when not logged in" do
    get :index
    assert_redirected_to login_url
  end

  describe "GET new" do
    it "returns http success" do
      get :new
      expect(response).to have_http_status(:success)
    end
  end

  it "should redirect to log in when not logged in" do
    get :edit, id: @user
    expect(flash).to be_present
    assert_redirected_to login_url
  end

  it "should redirect to update when not logged in" do
    patch :update, id: @user, user: {name: @user.name, email: @user.email}
    expect(flash).to be_present
    assert_redirected_to login_url
  end

  it "will not allow edit if logged in as wrong user" do
    session[:user_id] = @other_user.id
    get :edit, id: @user
    expect(flash).not_to be_present
    assert_redirected_to root_url
  end

  it "will not allow update if logged in as wrong user" do
    session[:user_id] = @other_user.id
    patch :update, id: @user, user: {name: @user.name, email: @user.email}
    expect(flash).not_to be_present
    assert_redirected_to root_url
  end

  it "will redirect destroy when not logged in" do
    @count = User.count
    delete :destroy, id: @user
    expect(User.count).to eq(@count)
    assert_redirected_to login_url
  end

  it "should redirect destory when logged in as a non-admin" do
    session[:user_id] = @other_user.id
    @count = User.count
    delete :destroy, id: @user
    expect(User.count).to eq(@count)
    assert_redirected_to root_url
  end

  it "will redirect following when not logged in" do
    get :following, id: @user
    assert_redirected_to login_url
  end
  
  it "will redirect followers when not logged in" do
    get :followers, id: @user
    assert_redirected_to login_url
  end

end
