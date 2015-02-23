require 'rails_helper'

RSpec.describe "UsersIndexTest" do

  before :each do
    @user = FactoryGirl.create :bijal
    (1..40).each do |i|
      username = "user_#{i}"
      FactoryGirl.create username.to_sym
    end
  end

  it "index including pagination" do
    get login_path
    post login_path, session: { email: @user.email, password: "password" }
    get users_path
    expect(response).to render_template('users/index')
    expect(response.body).to have_tag('div.pagination')
    User.paginate(page: 1).each do |user|
      expect(response.body).to have_tag('li', :href => "#{user_path(user)}", text: user.name)
    end
  end
  
end
