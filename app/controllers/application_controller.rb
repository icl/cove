class ApplicationController < ActionController::Base
  protect_from_forgery
 
  helper_method :is_admin?

  def is_admin? 
    current_user.kind == "admin"
  end
  
  def require_admin
  	unless is_admin?
  	  flash[:notice] = "You must be an admin to access this page"
  	  redirect_to :controller => "home", :action => "index"
  	end
  end
  
end

