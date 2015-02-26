require 'rails_helper'

RSpec.describe "PasswordResetsTest" do
  before :each do
    ActionMailer::Base.deliveries.clear
    @user = User.find_by(email: "bijalpatel@hotmail.com")
  end

  it "reset password" do
    get new_password_reset_path
    expect(response).to render_template('password_resets/new')
    # Invalid email
    post password_resets_path, password_reset: { email: "" }
    expect(flash).to be_present
    expect(response).to render_template('password_resets/new')
    # Valid email
    post password_resets_path, password_reset: { email: @user.email }
    expect(@user.reload.reset_digest).to eq(@user.reset_digest)
    expect(ActionMailer::Base.deliveries.size).to eq(1)
    expect(flash).to be_present
    assert_redirected_to root_url
    # Password reset form
    user = assigns(:user)
    # Wrong email
    get edit_password_reset_path(user.reset_token, email: "")
    assert_redirected_to root_url
    # Inactive user
    user.toggle!(:activated)
    get edit_password_reset_path(user.reset_token, email: user.email)
    assert_redirected_to root_url
    user.toggle!(:activated)
    # Right email, wrong token
    get edit_password_reset_path('wrong token', email:user.email)
    assert_redirected_to root_url
    # Right email, right token
    get edit_password_reset_path(user.reset_token, email:user.email)
    expect(response).to render_template('password_resets/edit')
    expect(response.body).to have_tag('input', type: :hidden, name: :email, value: user.email)
    # Invalid password & confirmation
    patch password_reset_path(user.reset_token),
      email: user.email,
      user: { password:              "foobaz",
              password_confirmation: "barquux" }
    expect(response.body).to have_tag('div', class: :field_with_errors)
    # Blank password
    patch password_reset_path(user.reset_token),
      email: user.email,
      user: { password:              "  ",
              password_confirmation: "barquux" }
    expect(flash).to be_present
    expect(response).to render_template('password_resets/edit')
    # Valid password and confirmation
    patch password_reset_path(user.reset_token),
      email: user.email,
      user: { password:              "foobaz",
              password_confirmation: "foobaz" }
    assert is_logged_in?
    expect(flash).to be_present
    assert_redirected_to user_path(user)
  end
end
