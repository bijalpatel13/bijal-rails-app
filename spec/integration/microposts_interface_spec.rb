require 'rails_helper'

RSpec.describe "MicropostsInterfaceTest" do

  before :each do
    @user = User.find_by(email: "bijalpatel@hotmail.com")
    FactoryGirl.create :orange
    FactoryGirl.create :tau_manifesto
    FactoryGirl.create :cat_video, user: @user
    FactoryGirl.create :most_recent
    (1..30).each do |i|
      micropost = "micropost_#{i}"
      FactoryGirl.create micropost.to_sym
    end
  end

  it "micropost interface" do
    get login_path
    post login_path, session: { email: @user.email, password: "password" }
    get root_path
    expect(response.body).to have_tag('div.pagination')
    # Invalid submission
    count = Micropost.count
    post microposts_path, micropost: { content: "" }
    expect(Micropost.count).to eq(count)
    expect(response.body).to have_tag('div#error_explanation')
    # Valid submission
    content = "This micropost realy works"
    count = Micropost.count
    post microposts_path, micropost: { content: content }
    expect(Micropost.count).to eq(count+1)
    assert_redirected_to root_url
    follow_redirect!
    expect(response.body).to match(content)
    # Delete a post.
    expect(response.body).to have_tag('a', text: 'delete')
    first_micropost = @user.microposts.paginate(page: 1).first
    count = Micropost.count
    delete micropost_path(first_micropost)
    expect(Micropost.count).to eq(count-1)
    get user_path(User.find_by(email: "example@railstutorial.org"))
    expect(response.body).not_to have_tag('a', text: 'delete')
  end
end
