require 'base64'
require 'cgi'

class CalendarsController < ApplicationController

  before_filter :auth_google

  def index
    @calendars = load_calendars
  end

  def show
    id = Base64.decode64(CGI::unescape(params[:id]))
    @calendar = load_calendar(id)
    @events = load_events(@calendar)
  end

  private

  def auth_google
    @service = GCal4Ruby::Service.new
    @service.debug = false
    @service.authenticate(ENV['GOOGLE_EMAIL'], ENV['GOOGLE_PASSWORD'])
  end

  def load_calendars
    @service.calendars
  end

  def load_calendar(id)
    GCal4Ruby::Calendar.find(@service, { :id => id })
  end

  def load_events(calendar)
    calendar.events.sort { |a, b| a.start_time <=> b.start_time }.reverse
  end

end
