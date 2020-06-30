class RequestAuthorization
  def initialize(headers)
    @headers = headers
    @decoded = nil
  end

  def user
    Admin.find(@decoded[:admin_id]) if valid?
  end

  def valid?
    return false unless token? 
    @decoded = JsonWebToken.instance.decode(@headers['Authorization'])
    @decoded && @decoded[:admin_id].present?
  end

  def token?
    @headers['Authorization'].present?
  end
end