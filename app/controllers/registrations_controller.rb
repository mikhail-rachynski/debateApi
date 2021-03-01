class RegistrationsController < Devise::RegistrationsController

  def create
    user = User.new(sign_up_params)
    p user
    if user.save
      token = current_user.generate_jwt
      render json: token.to_json
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end

end