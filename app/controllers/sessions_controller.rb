class SessionsController < ApplicationController
  def create
    admin = Admin.find_by_email(session_params[:email])
    if admin.try(:authenticate, session_params[:password])
      token = JsonWebToken.instance.encode({admin_id: admin.id})
      render json: {token: token}, status: :created
    else
      render :head, status: :unauthorized
    end
  end

  private

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
