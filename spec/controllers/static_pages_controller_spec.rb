require 'rails_helper'
require 'spec_helper'

include RSpecHtmlMatchers

RSpec.describe StaticPagesController, :type => :controller do
  render_views

  it "should get home" do
    get :home
    expect(response).to have_http_status(200)
    expect(response.body).to have_tag('title', :text =>"Home | Bijal's App with Ruby on Rails")
  end

  it "should get help" do
    get :help
    expect(response).to have_http_status(200)
    expect(response.body).to have_tag('title', :text =>"Help | Bijal's App with Ruby on Rails")
  end

  it "should get about" do
    get :about
    expect(response).to have_http_status(200)
    expect(response.body).to have_tag('title', :text =>"About | Bijal's App with Ruby on Rails")
  end
  
end

