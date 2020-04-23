class Api::CredentialsController < Api::BaseController
  def me
    respond_with current_user
  end
end
