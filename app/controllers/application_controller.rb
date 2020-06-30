class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, :with => :record_not_found

  private

  def authorized_user
    RequestAuthorization.new(request.headers).user
  end

  def record_not_found
    render :head, status: 404
  end
end
