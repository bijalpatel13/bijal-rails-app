require 'rails_helper'

RSpec.describe "FollowersTest" do

  before :each do
    @user = User.find_by(email: "bijalpatel@hotmail.com")
    @other_user = User.find_by(email: "archer@railstutorial.org")
    get login_path
    post login_path, session: { email: @user.email, password: "password" }
    FactoryGirl.create :one
    FactoryGirl.create :two
    FactoryGirl.create :three
    FactoryGirl.create :four
  end

  it "following page" do
    get following_user_path(@user)
    assert !@user.following.empty?
    expect(response.body).to match(@user.following.count.to_s)
    @user.following.each do |user|
      expect(response.body).to have_tag('a', href: user_path(user))
    end
  end

  it "followers page" do
    get followers_user_path(@user)
    assert !@user.followers.empty?
    expect(response.body).to match(@user.followers.count.to_s)
    @user.followers.each do |user|
      expect(response.body).to have_tag('a', href: user_path(user))
    end
  end

  it "should follow a user the standard way" do
    count = @user.following.count
    post relationships_path, followed_id: @other_user.id
    expect(@user.following.count).to eq(count+1)
  end

  it "should follow a user with Ajax" do
    count = @user.following.count
    xhr :post, relationships_path, followed_id: @other_user.id
    expect(@user.following.count).to eq(count+1)
  end

  it "should unfollow a user the standard way" do
    @user.follow(@other_user)
    relationship = @user.active_relationships.find_by(followed_id: @other_user.id)
    count = @user.following.count
    delete relationship_path(relationship)
    expect(@user.following.count).to eq(count-1)
  end

  it "should unfollow a user with Ajax" do
    @user.follow(@other_user)
    relationship = @user.active_relationships.find_by(followed_id: @other_user.id)
    count = @user.following.count
    xhr :delete, relationship_path(relationship)
    expect(@user.following.count).to eq(count-1)
  end

end
