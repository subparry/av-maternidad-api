require 'rails_helper'

RSpec.describe "Admins", type: :request do
  it 'cannot be created via create route' do
    expect {post '/admins'}.to raise_error(ActionController::RoutingError)
  end
  
  context 'with right credentials' do
    it 'should authenticate admin user and deliver JWT' do
      create(:admin)
      post '/sign_in', params: {session: {email: 'john@doe.cl', password: '123123'}}
      expect(response).to have_http_status(:created)
      expect(JSON.parse(response.body)['token']).not_to be(nil)
    end
  end
  context 'with wrong credentials' do
    it 'should respond with 401 unauthorized' do
      create(:admin)
      post '/sign_in', params: {session: {email: 'john@doe.cl', password: '1231234'}}
      expect(response).to have_http_status(:unauthorized)
    end
  end
end
