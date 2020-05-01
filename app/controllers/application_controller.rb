class ApplicationController < ActionController::Base
  layout :layout_by_resource

  private

  def set_raven_context
    Raven.user_context(id: session[:current_user_id]) # or anything else in session
    Raven.extra_context(params: params.to_unsafe_h, url: request.url)
  end

  def layout_by_resource
    if devise_controller?
      "session"
    else
      "application"
    end
  end
end
