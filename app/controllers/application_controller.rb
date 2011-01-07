class ApplicationController < ActionController::Base
  #remember me funkcio a bejelntkezéshez
  protect_from_forgery
  include SessionsHelper
  
end
