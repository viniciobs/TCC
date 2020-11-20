class StocksController < ApplicationController
  before_action :set_stock, only: [:show, :edit, :update, :destroy]
  before_action :check_user_permission


  # GET /stocks
  # GET /stocks.json
  def index    

    @products = nil

    if params[:category].present? || params[:product].present? 
      @products = Product.all    
      @products = @products.filter_by_category(params[:category]) if params[:category].present?
      @products = @products.filter_by_name(params[:product]) if params[:product].present?
      @products = @products.select(:id)
    end

    @stocks = @products==nil ? Stock.all : Stock.where("product_id IN (?)", @products)
    @stocks = @stocks.filter_by_min_quantity(params[:min_quantity]) if params[:min_quantity].present?
    @stocks = @stocks.filter_by_max_quantity(params[:max_quantity]) if params[:max_quantity].present?
    @stocks = @stocks.paginate(:page => params[:page], :per_page => 10)     
  end

  # GET /stocks/1
  # GET /stocks/1.json
  def show
  end

  # GET /stocks/1/edit
  def edit
  end

  # POST /stocks
  # POST /stocks.json
  def create
    @stock = Stock.new(stock_params)

    respond_to do |format|
      if @stock.save
        format.html { redirect_to @stock, notice: 'Stock was successfully created.' }
        format.json { render :show, status: :created, location: @stock }
      else
        format.html { render :new }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stocks/1
  # PATCH/PUT /stocks/1.json
  def update
    respond_to do |format|
      if @stock.update(stock_params)
        format.html { redirect_to @stock, notice: 'Item ' + Product.find(@stock.product_id).name + ' foi atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @stock }
      else
        format.html { render :edit }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stocks/1
  # DELETE /stocks/1.json
  def destroy    

    @product = Product.where(id: @stock.product_id).first

    if @product.has_order_associated
      respond_to do |format|
        format.html { redirect_to stocks_url, notice: 'Não é possível remover o estoque pois o produto está associado a uma comanda.' }
        format.json { head :no_content }
      end
      
      return 
    end

    @stock.delete    
    @product.delete

    respond_to do |format|
      format.html { redirect_to stocks_url, notice: 'Item ' + @product.name + ' foi removido com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock
      @stock = Stock.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def stock_params
      params.require(:stock).permit(:product, :quantity)
    end

    def check_user_permission
      render_access_denied if !current_user.nil? && current_user.user_type != 'manager'
    end
end
