require 'rails_helper'

RSpec.describe "Sessions", type: :request do
  context 'POST /check_token' do
    it 'responds with valid: false if token expired or malformed' do
      headers = { "ACCEPT" => 'application/json' }
      post '/check_token', params: {token: 'some_false_token'}, headers: headers
      expect(JSON.parse(response.body)['valid']).to be(false)
    end

    it 'responds with valid: true if token not expired or malformed' do
      create(:admin)
      post '/sign_in', params: {session: {email: 'john@doe.cl', password: '123123'}}
      
      token = JSON.parse(response.body)['token']

      headers = { "ACCEPT" => 'application/json' }
      post '/check_token', params: {token: token}, headers: headers
      expect(JSON.parse(response.body)['valid']).to be(true)
    end
  end
end
