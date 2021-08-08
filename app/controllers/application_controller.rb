class ApplicationController < ActionController::API
  include Response
  include Wssender

  respond_to :json
  before_action :process_token
  before_action :cors_set_access_control_headers

  def cors_preflight_check
    if request.method == 'OPTIONS'
      cors_set_access_control_headers
      render json: '', content_type: 'application/json'
    end
  end

  protected

  def cors_set_access_control_headers
    response.headers['Access-Control-Allow-Origin'] = '*'
    response.headers['Access-Control-Allow-Methods'] = 'POST, GET, PUT, PATCH, DELETE, OPTIONS'
    response.headers['Access-Control-Allow-Headers'] = 'Origin, Content-Type, Accept, Authorization, Token, Auth-Token, Email, X-User-Token, X-User-Email'
    response.headers['Access-Control-Max-Age'] = '1728000'
  end

  private

  # Check for auth headers - if present, decode or send unauthorized response (called always to allow current_user)
  def process_token
    if request.headers['Authorization'].present?
      begin
        jwt_payload = JWT.decode(request.headers['Authorization'].split(' ')[1], Rails.application.secrets.secret_key_base).first
        @current_user_id = jwt_payload['id']
      rescue JWT::ExpiredSignature, JWT::VerificationError, JWT::DecodeError
        # @error = "Not authorized"
        # @error_code = 401
        # render 'api/v1/errors/error.json.jbuilder'

      end
    end
  end

  # If user has not signed in, return unauthorized response (called only when auth is needed)
  def authenticate_user!(options = {})
    head :unauthorized unless signed_in?
  end

  # set Devise's current_user using decoded JWT instead of session
  def current_user
    @current_user ||= super || User.find(@current_user_id)
  end

  # check that authenticate_user has successfully returned @current_user_id (user is authenticated)
  def signed_in?
    @current_user_id.present?
  end


end