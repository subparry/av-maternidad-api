RSpec.describe RequestAuthorization do
  before(:example) do
    create(:admin)
    @admin_id = Admin.last.id
    @jwt = JsonWebToken.instance.encode({admin_id: @admin_id})
    @expired_jwt = JsonWebToken.instance.encode({admin_id: @admin_id}, Time.now.to_i - 1)
  end
  it 'rejects requests without authorization header' do
    expect(RequestAuthorization.new({}.to_json).user).to eq(nil)
  end

  it 'retrieves admin user id when token present and valid' do
    auth = RequestAuthorization.new({'Authorization' => @jwt})
    expect(auth.user.id).to eq(@admin_id)
  end

  it 'returns nil when authorizing expired jwt' do
    auth = RequestAuthorization.new({'Authorization' => @expired_jwt})
    expect(auth.user).to eq(nil)
  end
end