module ApplicationHelper
  def request_from_ios_device?
    request.env["HTTP_USER_AGENT"] =~ /iPhone/
  end
end
