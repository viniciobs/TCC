class OrderItemsController < ApplicationController
  before_action :set_items, only: [:finish, :alter_item_state, :destroy]
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

  def destroy
    order = @item.order
    stock = Stock.where(product_id: @item.product_id).first

    ActiveRecord::Base.transaction do          
      stock.update!(quantity: stock.quantity + @item.quantity)
      @item.delete      
    end     
     
    respond_to do |format|
      format.html { redirect_to order, notice: 'Pedido removido com sucesso.' }
      format.json { render :show, status: :ok, location: order }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_items
      @item = OrderItem.find(params[:id])
    end

    def check_user_permission
      render_access_denied if current_user.nil? || !current_user.active? 
      render_access_denied if !@order.nil? && (current_user.user_type != 'manager' || current_user.user_type != 'kitchen')       
    end
end
