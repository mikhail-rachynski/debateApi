class RegistrationsController < Devise::RegistrationsController

  def create
    user = User.new(sign_up_params)
    if user.save
      user.update(name: params[:user][:name])
      token = user.generate_jwt
      render json: {token: token, current_user: user}
    else
      render json: { errors: { 'email or password' => ['is invalid'] } }, status: :unprocessable_entity
    end
  end

end