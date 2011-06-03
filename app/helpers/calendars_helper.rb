require 'base64'
require 'cgi'

module CalendarsHelper

  def decode_id(calendar)
    Base64.decode64(CGI::unescape(calendar.id))
  end

  def encode_id(calendar)
    CGI::escape(Base64.encode64(calendar.id).gsub("\n", ''))
  end

end
