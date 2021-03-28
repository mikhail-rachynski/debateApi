class SessionsController < Devise::SessionsController

  def create
    user = User.find_by_email(sign_in_params[:email])

    if user && user.valid_password?(sign_in_params[:password])
      token = current_user.generate_jwt
      render json: {token: token, current_user: user}
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end

  def is_logged_in?
    if signed_in?
      render json: {current_user: current_user}
    else
      render json: {error: "Not authorized"}
    end
  end

end