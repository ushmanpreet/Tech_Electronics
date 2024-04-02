class ApplicationController < ActionController::Base
    private

    def authenticate_admin
      unless admin_signed_in?
        redirect_to root_path, alert: 'You are not authorized to access this page.'
      end
    end

    def admin_signed_in?
      session[:admin_signed_in] == true
    end
  end
