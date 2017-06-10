class WelcomeController < ApplicationController
  def index
    flash[:notice] = "Good Morning!"
    flash[:alert] = "Good Night! It's time to sleep."
    flash[:warning] = "This is a warning information."
  end
end
