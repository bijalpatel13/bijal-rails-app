require 'rails_helper'

RSpec.describe Micropost, :type => :model do
  before :each do
    @user = User.find_by(email: "bijalpatel@hotmail.com")
    @micropost = @user.microposts.build(content: "Lorem ipsum")
  end

  it "will be valid" do
    assert @micropost.valid?
  end

  it "user id should be present" do
    @micropost.user_id = nil
    assert !@micropost.valid?
  end
  
  it "content should be present" do
    @micropost.content = "   "
    assert !@micropost.valid?
  end

  it "content should be at most 140 characters" do
    @micropost.content = "a" * 141
    assert !@micropost.valid?
  end

  it "order should be most recent first" do
    FactoryGirl.create :orange
    FactoryGirl.create :tau_manifesto
    FactoryGirl.create :cat_video
    microposts = FactoryGirl.create :most_recent
    expect(microposts).to eq(Micropost.first)
  end
end
