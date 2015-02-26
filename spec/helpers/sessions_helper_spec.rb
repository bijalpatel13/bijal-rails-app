require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the SessionsHelper. For example:
#
# describe SessionsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
RSpec.describe SessionsHelper, :type => :helper do

  before :each do
    @user = User.find_by(email: "bijalpatel@hotmail.com")
    remember(@user)
  end

  it "current_user returns the correct user when session is nil" do
    expect(@user).to eq(current_user)
    assert is_logged_in?
  end

  it "current_user returns nil when remember digest is wrong" do
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end

end
