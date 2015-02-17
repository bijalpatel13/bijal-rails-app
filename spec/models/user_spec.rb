require 'rails_helper'
require 'spec_helper'

RSpec.describe User, :type => :model do

  before :each do
    @user = User.new(name: "Test User", email: "user@test.com",
                     password: "password", password_confirmation: "password")
  end

  it "should be valid" do
    expect(@user).to be_valid
  end

  it "should have name" do
    @user.name = ""
    expect(@user).not_to be_valid
  end

  it "should have email" do
    @user.email = "   "
    expect(@user).not_to be_valid
  end

  it "name should not be too long" do
    @user.name = "a" * 51
    expect(@user).not_to be_valid
  end

  it "email should not be too long" do
    @user.email = "a" * 250 + "@test.com"
    expect(@user).not_to be_valid
  end

  it "email validation should accept valid addresses" do
    valid_addresses = %w[user@test.com USER@foo.COM A_US-ER@foo.bar.org 
      first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      expect(@user).to be_valid, "#{valid_address.inspect} should be valid"
    end
  end
  
  it "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@test,com USER+at_foo.COM A_US-ER@foo. 
      first.last@foo_baz.jp test@foo..com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      expect(@user).not_to be_valid, "#{invalid_address.inspect} should be invalid"
    end
  end

  it "email addresses should be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    expect(duplicate_user).not_to be_valid
  end

  it "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMplE.CoM"
    @user.email = mixed_case_email
    @user.save
    expect(@user.email).to eq(mixed_case_email.downcase)
  end

  it "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    expect(@user).not_to be_valid
  end

end
