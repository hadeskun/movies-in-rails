class WelcomeController < ApplicationController

	before_filter :require_login, :only => :secret
	
  def index
  end
end
