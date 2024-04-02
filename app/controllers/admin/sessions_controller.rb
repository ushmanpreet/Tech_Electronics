class Admin::SessionsController < ApplicationController
  def login
  end

  def dashboard
    redirect_to admin_login_path unless session[:admin_logged_in]
    @products = Product.all
    render 'admin/products/index'
  end

  def authenticate
    username = params[:username]
    password = params[:password]

    if username == 'admin' && password == 'password'
      session[:admin_logged_in] = true
      redirect_to admin_dashboard_path, notice: 'Logged in successfully.'
    else
      redirect_to admin_login_path, alert: 'Invalid username or password.'
    end
  end

  def destroy
    session[:admin_logged_in] = nil
    redirect_to root_path, notice: 'Logged out successfully.'
  end
end
