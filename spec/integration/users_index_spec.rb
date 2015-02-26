require 'rails_helper'

RSpec.describe "UsersIndexTest" do

  before :each do
    @admin = User.find_by(email: "bijalpatel@hotmail.com")
    @non_admin = User.find_by(email: "example@railstutorial.org")
    (1..40).each do |i|
      username = "user_#{i}"
      FactoryGirl.create username.to_sym
    end
  end

  it "index including pagination" do
    get login_path
    post login_path, session: { email: @admin.email, password: "password" }
    get users_path
    expect(response).to render_template('users/index')
    expect(response.body).to have_tag('div.pagination')
    User.paginate(page: 1).each do |user|
      expect(response.body).to have_tag('li', :href => "#{user_path(user)}", text: user.name)
      unless user == @admin
        expect(response.body).to have_tag('li', :href => "#{user_path(user)}", text: 'delete',
                                         method: :delete)
      end        
    end

    @count = User.count
    delete user_path(@non_admin)
    expect(User.count).to eq(@count-1)
  end
  
  it "index as non-admin" do
    get login_path
    post login_path, session: { email: @non_admin.email, password: "password" }
    get users_path
    expect(response.body).not_to have_tag('a', :href => "#{user_path(@non_admin)}", text: 'delete',
                                      method: :delete)
  end
end
