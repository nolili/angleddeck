class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def posted_json(as: )
    as.coerce(JSON.parse(request.raw_post, symbolize_names: true))
  end

  def reject_if_not_json_request
    unless request.format.json?
      render status: 400, json: ["Send me request as JSON"]
    end
  end
end
