class SessionsController < ApplicationController
  def new
    @title = "Sign in"
  end
  
  def create
    #bejelntkezesi fgv ami meg van valositva
    user = User.authenticate(params[:session][:email],
                             params[:session][:password])
    if user.nil?
      #Create an error message and re-render the sign in form.
      flash.now[:error] = "Invalid email/password combination."
      @title = "Sign in"
      #belepees a sessions/new.html.erb-be de elotte volt egy routes.rb
      render 'new' 
    else
      #sigin the user in and redirect to the user's show page
      sign_in user
      redirect_back_or user
    end
  end
  
  def destroy
    sign_out
    redirect_to root_path
  end

end
