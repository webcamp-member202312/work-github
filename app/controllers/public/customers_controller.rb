class Public::CustomersController < ApplicationController
   before_action :authenticate_customer!
   
   def show
      @customer = current_customer
   end
   
   def edit
     @customer = Customer.find(current_customer.id)
   end
   
   def unsubscribe
   end
   
   def update
   end
   
   def withdraw
      @customer = Customer.find(current_customer.id)
      @customer.update(is_active: false)
      reset_session
      redirect_to customers_my_page_path
   end
   
   private
   
   def public_customers_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kane, :first_name_kana)
   end
end
