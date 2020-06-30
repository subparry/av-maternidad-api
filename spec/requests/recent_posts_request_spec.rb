require 'rails_helper'

RSpec.describe RecentPostsController, type: :request do
  before(:example, :get) do
    headers = { "ACCEPT" => 'application/json' }
    get "/recent_posts", headers: headers
  end

  context 'GET /recent_posts' do
    it 'delivers empty array if there is no recent posts', get: true do
      expect(JSON.parse response.body).to be_empty
    end

    it 'delivers 2 items if there is only 2 posts' do
      create(:post)
      create(:post)
      headers = { "ACCEPT" => 'application/json' }
      get "/recent_posts", headers: headers
      expect(JSON.parse(response.body).length).to be(2)
    end 

    it 'delivers 3 items if there are 10 posts' do
      10.times do
        create(:post)
      end
      headers = { "ACCEPT" => 'application/json' }
      get "/recent_posts", headers: headers
      expect(JSON.parse(response.body).length).to be(3)
    end 
  end
end