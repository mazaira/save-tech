class Api::CredentialsController < ApplicationController
  before_action :doorkeeper_authorize!

  def me
    respond_with current_resource_owner
  end

  private

  def current_resource_owner
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
