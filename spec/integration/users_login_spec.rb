require 'rails_helper'
require 'spec_helper'

RSpec.describe "UsersLoginTest" do

  before :each do
    @user = FactoryGirl.create :bijal
  end

  it "will fail login with invalid information" do
    get login_path
    expect(response).to render_template('sessions/new')
    post login_path, session: { email: "", password: "" }
    expect(response).to render_template('sessions/new')
    expect(flash).to be_present
    get root_path
    expect(flash).not_to be_present
  end

  it "login with valid information" do
    get login_path
    post login_path, session: { email: @user.email, password: "password" }
    #binding.pry
    assert is_logged_in?
    assert_redirected_to user_path(@user)
    follow_redirect!
    expect(response.body).not_to have_tag('li', text: "#{login_path}")
    expect(response.body).to have_tag('li', href: "#{logout_path}")
    expect(response.body).to have_tag('li', href: "#{user_path(@user)}")
    delete logout_path
    assert !is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    expect(response.body).not_to have_tag('li', text: "#{logout_path}")
    expect(response.body).not_to have_tag('li', text: "#{user_path(@user)}")
  end

  it "login with remembering" do
    get login_path
    post login_path, session: { email: @user.email, password: "password",
    remember_me: '1'}
    assert !cookies['remember_token'].nil?
  end

  it "login without remembering" do
    assert_nil cookies['remember_token']
    get login_path
    post login_path, session: { email: @user.email, password: "password",
    remember_me: '0'}
  end

end
