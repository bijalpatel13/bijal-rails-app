require 'rails_helper'

RSpec.describe "UsersProfileTest" do
  include ApplicationHelper

  before :each do
    @user = FactoryGirl.create :bijal
    FactoryGirl.create :orange, user: @user
    FactoryGirl.create :tau_manifesto, user: @user
    FactoryGirl.create :cat_video, user: @user
    FactoryGirl.create :most_recent, user: @user
    (1..30).each do |i|
      micropost = "micropost_#{i}"
      FactoryGirl.create micropost.to_sym, user: @user
    end
  end

  it "will display profile" do
    get user_path(@user)
    expect(response).to render_template('users/show')
    expect(response.body).to have_tag('title', full_title(@user.name))
    expect(response.body).to have_tag('img', alt: @user.name, class: "gravatar")
    expect(response.body).to match(@user.microposts.count.to_s)
    expect(response.body).to have_tag('div.pagination')
    @user.microposts.paginate(page: 1).each do |micropost|
      expect(response.body).to match(micropost.content)
    end
  end

end
