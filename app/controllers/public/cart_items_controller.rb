class Public::CartItemsController < ApplicationController
  before_action :authenticate_customer!
  
  def index
    @cart_item = CartItem.new
    @cart_items = CartItem.all
  end
  
  def update
  end
  
  def destroy
  end
  
  def destroy_all
  end
  
  def create
    @cart_item = CartItem.new(cart_item_params)
    @cart_item.item_id = current_customer.id
    @cart_item.save
    redirect_to cart_items_path
    
  end
  
  private
 
  def cart_item_params
    params.require(:cart_item).permit(:item_id, :amount)
  end
end
