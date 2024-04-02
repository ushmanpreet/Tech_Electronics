class Admin::BaseController < ApplicationController
  def login
  end

  def authenticate
    username = params[:username]
    password = params[:password]

    if username == 'admin' && password == 'password'
      redirect_to admin_dashboard_path
    else
      redirect_to admin_login_path, alert: "Invalid username or password"
    end
  end

  def dashboard
      @products = Product.all
  end
end
