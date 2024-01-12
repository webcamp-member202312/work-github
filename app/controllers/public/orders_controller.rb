class Public::OrdersController < ApplicationController
   before_action :authenticate_customer!
   
   def new
      @order = Order.new
   end
   
   def confirm
      @order = Order.new(order_params)
      @address = Address.find(params[:order][:address_id])
      @order.postal_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name = current_customer.first_name + current_customer.last_name
      
      @cart_items = current_customer.cart_items.all
   end
   
   def complete
   end
   
   def create
      @order = Order.new(order_params)
      @order.customer_id = current_customer.id
      @selected_address = params[:order][:select_address]
      @order.save
      redirect_to orders_confirm_path
   end
   
   def index
   end
   
   def show
   end
   
   private
   
   def order_params
     params.require(:order).permit(:cutomer_id, :postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
   end
end
