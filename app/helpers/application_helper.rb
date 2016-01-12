module ApplicationHelper
  def request_from_ios_device?
    request.env["HTTP_USER_AGENT"].try do |ua|
      ua =~ /iPhone/ || ua =~ /iPad/ || ua =~ /iPod/
    end
  end
end
