class AutenticacaoController < ApplicationController
  before_action :authorize_request, only: [:profile]

SECRET_KEY = Rails.application.credentials.secret_key_base || ENV['SECRET_KEY']

  def login
    user = Usuario.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      token = encode_token({ user_id: user.id })
      render json: { token: token, user: { email: user.email } }
    else
      render json: { error: 'Credenciais inválidas' }, status: :unauthorized
    end
  end

  def profile
    render json: { user: @current_user }
  end

  private

  def encode_token(payload)
    JWT.encode(payload, SECRET_KEY)
  end

  def authorize_request
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    begin
      decoded = JWT.decode(token, SECRET_KEY)[0]
      @current_user = Usuario.find(decoded["user_id"])
    rescue JWT::DecodeError
      render json: { error: 'Token inválido' }, status: :unauthorized
    end
  end
end
