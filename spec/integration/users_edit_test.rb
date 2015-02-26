require 'rails_helper'
require 'spec_helper'

RSpec.describe "UsersLoginTest" do

  before :each do
    @user = User.find_by(email: "bijalpatel@hotmail.com")
  end

  it "unsuccessful edit" do
    get edit_user_path(@user)
    expect(response).to render_template('users/edit')
    patch user_path(@user), user: { name: "",
                                    email: "bijalpatel@hotmail.com",
                                    password: "foo",
                                    password_confirmation: "bar" }
    expect(response).to render_template('users/edit')
  end

  it "successful edit" do
    get edit_user_path(@user)
    post login_path, session: { email: @user.email, password: @user.password }
    assert_redirected_to edit_user_path(@user)
    expect(response).to render_template('users/edit')
    name = "Bijal P"
    email= "example@railstutorial.org"
    patch user_path(@user), user: { name: name,
                                    email: email,
                                    password: "",
                                    password_confirmation: "" }
    expect(flash).to be_present
    assert_redirected_to user_path(@user)
    @user.reload
    expect(@user.name).to eq(name)
    expect(@user.email).to eq(email)
  end

end
