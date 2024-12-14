class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by_email(params[:email])
    # If the user exists AND the password entered is correct.
    if user && user.authenticate(params[:password])
      # Save the user id inside the browser cookie. This is how we keep the user 
      # logged in when they navigate around our website.
      session[:user_id] = user.id
      redirect_to '/', notice: "Logged in successfully."
    else
      # If user's login doesn't work, send them back to the login form.
      redirect_to '/login', notice: "Information incorrect"
    end
  end

  def destroy
    # Better to use delete so it doesnt leave a key in the session hash {user_id: nil}
    # session[:user_id] = nil
    session.delete(:user_id)
    redirect_to '/login', notice: "Logged out successfully."
  end
end
