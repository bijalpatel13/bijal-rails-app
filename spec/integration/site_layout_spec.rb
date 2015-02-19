require 'rails_helper'
require 'spec_helper'

RSpec.describe "SiteLayoutTest" do

  it "should have the right layout links" do
    get root_path
    expect(response.body).to have_tag('li', :href => "#{root_path}", count: 6)
    expect(response.body).to have_tag('li', href: "#{help_path}")
    expect(response.body).to have_tag('li', href: "#{about_path}")
    expect(response.body).to have_tag('li', href: "#{contact_path}")
    expect(response.body).to have_tag('li', href: "#{signup_path}")
  end
end
