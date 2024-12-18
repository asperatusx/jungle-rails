class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  
  protect_from_forgery with: :exception

  def current_user
    # Uses memoization to save info in current user before making a query
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  # allows us to use @current_user in our view files
  helper_method :current_user

  # Authorize is for sending someone to the login page if they aren't logged in
  def authorize
    redirect_to '/login' unless current_user
  end
  # With Authorize I can add the below line to any controller to restrict access unless they login
  #before_filter :authorize

  private

  def cart
    @cart ||= cookies[:cart].present? ? JSON.parse(cookies[:cart]) : {}
  end
  helper_method :cart

  def enhanced_cart
    @enhanced_cart ||= Product.where(id: cart.keys).map {|product| { product:product, quantity: cart[product.id.to_s] } }
  end
  helper_method :enhanced_cart

  def cart_subtotal_cents
    enhanced_cart.map {|entry| entry[:product].price_cents * entry[:quantity]}.sum
  end
  helper_method :cart_subtotal_cents


  def update_cart(new_cart)
    cookies[:cart] = {
      value: JSON.generate(new_cart),
      expires: 10.days.from_now
    }
    cookies[:cart]
  end
end
