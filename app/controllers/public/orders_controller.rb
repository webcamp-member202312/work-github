class Public::OrdersController < ApplicationController
   before_action :authenticate_customer!

   def new
      @order = Order.new
   end

   def confirm
      @cart_items = current_customer.cart_items.all
      @order = Order.new(order_params)
      if params[:order][:select_address] == "0"
        @order.postal_code = current_customer.postal_code
        @order.address = current_customer.address
        @order.name = current_customer.last_name + current_customer.first_name

      elsif params[:order][:select_address] == "1"
        ship = Address.find(params[:order][:address_id])
        @order.postal_code = ship.postal_code
        @order.address = ship.address
        @order.name = ship.name

      elsif params[:order][:select_address] == "2"
        @order.postal_code = params[:order][:postal_code]
        @order.address = params[:order][:address]
        @order.name = params[:order][:name]
      end


   end

   def complete
   end

   def create
      order_params[:status] = order_params[:status].to_i
      @order = Order.new(order_params)
      @order.customer_id = current_customer.id
      @selected_address = params[:order][:select_address]
      @order.save
      @cart_items = current_customer.cart_items.all

      if @order.save
        @cart_items.each do |cart_item|
          OrderDetail.create!(order_id: @order.id, item_id: cart_item.item.id, price: cart_item.item.price, amount: cart_item.amount, making_status: 0)
        end
      @cart_items.destroy_all
      end

      @order.customer_id = current_customer.id
      redirect_to orders_complete_path
   end

   def index
      @orders = current_customer.orders
      @total = 0
   end

   def show
     @order = Order.find(params[:id])
     @total = 0
     @order_details = OrderDetail.where(order_id: params[:id])
   end

   private

   def order_params
     params.require(:order).permit(:postal_code, :address, :name, :shipping_cost, :total_payment, :payment_method, :status)
   end
end
