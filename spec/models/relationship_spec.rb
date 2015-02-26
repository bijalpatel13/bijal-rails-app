require 'rails_helper'

RSpec.describe Relationship, :type => :model do
  before do
    @relationship = Relationship.new(follower_id: 1, followed_id:2)
  end

  it "will be valid" do
    assert @relationship.valid?
  end

  it "should require a follower_id" do
    @relationship.follower_id = nil
    assert !@relationship.valid?
  end

  it " will require a followed_id" do
    @relationship.followed_id = nil
    assert !@relationship.valid?
  end

end
