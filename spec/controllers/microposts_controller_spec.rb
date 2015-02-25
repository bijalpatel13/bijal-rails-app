require 'rails_helper'

RSpec.describe MicropostsController, :type => :controller do
  before :each do
    @user = FactoryGirl.create :bijal
    @micropost = FactoryGirl.create :orange, user: @user
  end

  it "will redirect create when not logged in" do
    @count = Micropost.count
    post :create, micropost: { content: "Lorem ipsum" }
    expect(Micropost.count).to eq(@count)
    assert_redirected_to login_url
  end

  it "will redirect destroy when not logged in" do
    @count = Micropost.count
    delete :destroy, id: @micropost
    expect(Micropost.count).to eq(@count)
    assert_redirected_to login_url
  end

  it "will redirect destroy for wrong micropost" do
   @test = FactoryGirl.create :example
   session[:user_id] = @user.id
   micropost = FactoryGirl.create :cat_video, user: @test
   @count = Micropost.count
   delete :destroy, id: micropost
   expect(Micropost.count).to eq(@count)
   assert_redirected_to root_url
  end

end
