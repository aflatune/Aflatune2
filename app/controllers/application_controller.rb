require "net/https"

class ApplicationController < ActionController::Base
  #protect_from_forgery
  
  before_filter { |c| User.current_user = c.current_user; }
  
  def index
  end
end
