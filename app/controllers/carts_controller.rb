class CartsController < ApplicationController
  def show
    @cart = current_cart
  end

  def checkout
    cart = Cart.find(params[:id])
    cart.place_order
    current_user.current_cart = nil
    current_user.save

    redirect_to cart_path(cart)
  end

end
