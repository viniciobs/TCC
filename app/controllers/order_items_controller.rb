class OrderItemsController < ApplicationController
  before_action :set_items, only: [:finish, :alter_item_state]
  before_action :check_user_permission

  def index
    @result = []

    items = OrderItem.where.not(status: 'done').order(:created_at) 
    items.each do |item|
      product = Product.find(item.product_id)
      @result << { item: item, product: product, table_num: item.order.table_num }
    end
  end

  # Este método é utilizada para indicar que o pedido está sendo preparado ou já está pronto e não pode ser cancelado
  def alter_item_state
    status = params[:status].to_i

    if status>=0 && status<=2
      @item.status = status
      @item.save
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_items
      @item = OrderItem.find(params[:id])
    end

    def check_user_permission
      render_404 if current_user.nil? || !current_user.active? 
      render_404 if !@order.nil? && (current_user.user_type != 'manager' || current_user.user_type != 'kitchen')       
    end
end
