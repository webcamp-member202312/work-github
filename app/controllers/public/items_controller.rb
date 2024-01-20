class Public::ItemsController < ApplicationController
  
  def index
    @items = Item.page(params[:page])
    if params[:keyword].present?
      @products = Item.where(name: params[:property_name])
    else
      @products = Item.all
    end
  end
  
  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
  end
  
  private
  
  def item_params
  params.require(:item).permit(:genre_id,:name,:introduction,:price ,:is_active, :image)
  end
end
