require 'rails_helper'

RSpec.describe MicropostsController, :type => :controller do
  before :each do
    @user = User.find_by(email: "bijalpatel@hotmail.com")
    @micropost = FactoryGirl.create :orange
  end

  it "will redirect create when not logged in" do
    count = Micropost.count
    post :create, micropost: { content: "Lorem ipsum" }
    expect(Micropost.count).to eq(count)
    assert_redirected_to login_url
  end

  it "will redirect destroy when not logged in" do
    count = Micropost.count
    delete :destroy, id: @micropost
    expect(Micropost.count).to eq(count)
    assert_redirected_to login_url
  end

  it "will redirect destroy for wrong micropost" do
   test = User.find_by(email: "test@yahoo.com")
   session[:user_id] = @user.id
   micropost = FactoryGirl.create :cat_video, user: test
   count = Micropost.count
   delete :destroy, id: micropost
   expect(Micropost.count).to eq(count)
   assert_redirected_to root_url
  end

end
