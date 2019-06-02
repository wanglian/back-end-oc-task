class ApplicationController < ActionController::Base
  include ActionController::Caching::Sweeping
  protect_from_forgery with: :exception
end
