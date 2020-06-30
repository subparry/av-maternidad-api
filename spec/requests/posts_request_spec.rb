require 'rails_helper'

RSpec.describe PostsController, type: :request do
  before(:example, :get) do
    headers = { "ACCEPT" => 'application/json' }
    get "/posts", headers: headers
  end

  before(:example, :authed) do
    create(:admin)
    post '/sign_in', params: {session: {email: Admin.last.email, password: '123123'}}
    @jwt = JSON.parse(response.body)['token']
  end

  context 'GET /posts' do
    it 'responds with correct content-type', get: true do
      expect(response.content_type).to eq('application/json')
    end

    it 'returns empty array if no posts present', get: true do
      expect(JSON.parse response.body).to be_empty
    end

    it 'returns post collection if posts present' do
      headers = { "ACCEPT" => 'application/json' }
      create(:post)
      get "/posts", headers: headers
      expect(JSON.parse response.body).not_to be_empty
    end
  end

  context 'POST /posts' do
    it 'responds with 401 unauthorized if not authenticated' do
      headers = { "ACCEPT" => 'application/json' }
      post "/posts", params: { post: attributes_for(:post)}
      expect(response).to have_http_status(:unauthorized)
    end

    context 'authenticated admin' do
      it 'creates a new post when using correct parameters', authed: true do        
        expect { post "/posts", params: { post: attributes_for(:post)}, headers: {'Authorization': @jwt} }.to change { Post.count }.by(1)
        expect(response).to have_http_status(:created)
      end
      
      it 'returns unprocessable entity when using wrong parameters', authed: true do
        post "/posts", params: { post: attributes_for(:post, title: '')}, headers: {'Authorization': @jwt}
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  context 'GET /post/:id' do
    it 'retrieves post by id' do
      create(:post)
      get "/post/#{Post.last.id}"
      expect(JSON.parse(response.body)['title']).to eq(Post.last.title)
    end

    it 'returns 404 if post not found' do
      create(:post)
      get "/post/#{Post.last.id + 10}"
      expect(response).to have_http_status(404)
    end
  end
end
