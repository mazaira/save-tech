class ApplicationController < ActionController::Base
  layout :layout_by_resource

  rescue_from ActionController::UnknownFormat, with: :render_fuck_you

    private
  def render_fuck_you
    render json: { hey: "you are trying to break the app. Just don't do it!"}
  end

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
