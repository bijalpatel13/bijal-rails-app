require 'rails_helper'

RSpec.describe RelationshipsController, :type => :controller do

  it "create should require logged-in user" do
    count = Relationship.count
    post :create
    expect(Relationship.count).to eq(count)
    assert_redirected_to login_url
  end

  it "destroy should require logged-in user" do
    relation = FactoryGirl.create :one
    count = Relationship.count
    delete :destroy, id: relation
    expect(Relationship.count).to eq(count)
    assert_redirected_to login_url
  end

end
