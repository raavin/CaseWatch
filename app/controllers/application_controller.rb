class ApplicationController < ActionController::Base
 unloadable
  #helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details
  #before_filter { |c| Authorization.current_user = c.current_user }
  #filter_parameter_logging :password
  
  #File.rename("/Users/jason/testlink2.txt", "/Users/jason/#{SecureRandom.base64()}.txt")
  #File.symlink("/Users/jason/testfile.txt", "/Users/jason/#{SecureRandom.hex()}.txt")
  
  def permission_denied  
    flash[:error] = "Sorry, you not allowed to access that page."  
    redirect_to root_url  
  end
  
  #before_filter :set_current_user
   protected
   def set_current_user
     Authorization.current_user = current_user
   end
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
