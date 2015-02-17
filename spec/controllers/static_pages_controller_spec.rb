require 'rails_helper'
require 'spec_helper'

RSpec.describe StaticPagesController, :type => :controller do

  render_views
  before :each do
    @base_title = "Bijal's App with Ruby on Rails"
  end

  it "should get home" do
    get :home
    expect(response).to have_http_status(200)
    expect(response.body).to have_tag('title', :text =>"#{@base_title}")
  end

  it "should get help" do
    get :help
    expect(response).to have_http_status(200)
    expect(response.body).to have_tag('title', :text =>"Help | #{@base_title}")
  end

  it "should get about" do
    get :about
    expect(response).to have_http_status(200)
    expect(response.body).to have_tag('title', :text =>"About | #{@base_title}")
  end
  
  it "should get contact" do
    get :contact
    expect(response).to have_http_status(200)
    expect(response.body).to have_tag('title', :text =>"Contact | #{@base_title}")
  end

end

