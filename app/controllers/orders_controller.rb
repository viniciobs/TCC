class OrdersController < ApplicationController
  before_action :set_order, only: [:show, :edit, :update, :destroy]
  before_action :check_user_permission

  # GET /orders
  # GET /orders.json
  def index
    @orders = Order.all  
    @orders = @orders.filter_by_table_num(params[:table_num]) if params[:table_num].present?

    if params[:user_name].present?
      @users = User.all 
      @users = @users.filter_by_name(params[:user_name])

      @orders = @orders.where('user_id IN (?)', @users.select(:id))
    end
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order_items = @order.order_items
  end

  # GET /orders/new
  def new
    @order = Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = Order.new(order_params)

    if @order.user.nil?
      respond_to do |format|
        flash.now[:notice] = "O id informado não pertence a nenhum usuário."
        format.html { render :new }      
      end

      return
    end 

    if user_has_order_already
      respond_to do |format|
        flash.now[:notice] = "Já existe uma comanda para o usuário: " + @order.user.name + "."
        format.html { render :new }      
      end

      return
    end

    respond_to do |format|
      if @order.save

        user = @order.user
        user.active = true
        user.save

        format.html { redirect_to @order, notice: 'A comanda foi criada com sucesso.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'A comanda foi atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    user = @order.user
    user.active = false
    user.save

    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Comanda excluída com sucesso.' }
      format.json { head :no_content }
    end
  end


  def handle    
    order = Order.find(params[:id])
    product = Product.find(params[:product_id])
    quantity = params[:quantity].to_i

    stock = get_stock(product, quantity)  

    render :json => nil, :status => :unprocessable_entity if stock.nil? 
    
    ActiveRecord::Base.transaction do          
      stock.update!(quantity: stock.quantity - quantity)
      OrderItem.create!(product_id: product.id, order_id: order.id, quantity: quantity)          
    end   

    render :json => nil, :status => :ok  
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = Order.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def order_params
      params.require(:order).permit(:user_id, :table_num)
    end

    def user_has_order_already
      return Order.where('user_id=?', @order.user.id).any?
    end  

    def get_stock product, quantity
      return Stock.where('product_id=? AND quantity>=?', product, quantity).first
    end  

    def check_user_permission
      render_404 if current_user.nil? || !current_user.active? 
      render_404 if !@order.nil? && current_user.user_type != 'manager' && current_user.id != @order.user.id 
      render_404 if request.path == orders_path && current_user.user_type != 'manager'
    end
end
