# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  
  private
  def current_controller
    return self.controller_name.to_s.underscore.gsub(/_controller$/, '')
  end
  
  def current_action
    return self.action_name.underscore
  end
  
  def process_paginate(total_count, per_page=50)
    params[:page] ||= 1
    params[:per_page] ||= per_page
    limit = params[:per_page]
    @total_page = (total_count.to_f / limit).ceil    
    params[:page] = @total_page if params[:page].to_i == -1
    offset = ((params[:page].to_i) - 1) * limit
    return limit, offset
  end

  def manager?
    session[:auth] == 'asdf'
  end
end
