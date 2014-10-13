class UserSessionsController < ApplicationController

  skip_before_filter :require_login, except: [:destroy]

  def new
     @user = User.new	
  end

  def create
  	if @user = login(params[:email], params[:password])
  	  #'redirect_back_or_to' takes care of redirecting the
  	  # user to the page he asked for before reaching the login form, if such a page exists.
      redirect_back_or_to(:posts, notice: 'Login successful')
    else
      flash.now[:alert] = 'Login failed'
      render action: 'new'
    end
  end

  def destroy
  	logout
    redirect_to(:root, notice: 'Logged out!')
  end
end
