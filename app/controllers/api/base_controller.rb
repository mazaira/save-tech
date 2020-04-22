class Api::BaseController < ApplicationController
  before_action :check_auth

  respond_to :json

  private

  def check_auth
    render json: { error: 'Unauthorized'}, status: 401 unless user_signed_in?
  end

  # def current_user
  #   User.find_by_email token['email'] if request.headers['AUTHORIZATION']
  # end

  # TODO: implement key/secret verification
  def token
    @token ||= decode(bearer_token(request.headers['AUTHORIZATION'])).first['user']
  end

  def decode(token)
    JWT.decode token, nil, false
  end

  def bearer_token(auth_header)
    pattern = /^Bearer /
    auth_header.gsub(pattern, '') if auth_header.match(pattern)
  end
end
