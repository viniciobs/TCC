class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :check_user_permission

  # GET /products
  # GET /products.json
  def index  
    @products = Product.all
    @products = @products.filter_by_category(params[:category]) if params[:category].present?
    @products = @products.filter_by_name(params[:name]) if params[:name].present?
    @products = @products.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /products/1
  # GET /products/1.json
  def show
  end

  # GET /products/new
  def new
    @product = Product.new
  end

  # GET /products/1/edit
  def edit
  end

  # POST /products
  # POST /products.json
  def create
    @product = Product.new(product_params)

    if exists @product.name 
      respond_to do |format|
        flash.now[:notice] = "Já existe um produto cadastrado com este nome."
        format.html { render :edit }      
      end

      return
    end

    respond_to do |format|
      if @product.save  

        @stock = Stock.new
        @stock.product_id = @product.id     
        
        if !@stock.save 
          format.html { render :new }
          format.json { render json: @stock.errors, status: :unprocessable_entity }
          return
        end

        format.html { redirect_to @product, notice: @product.name + ' criado com sucesso.' }
        format.json { render :show, status: :created, location: @product }         
      else
        format.html { render :new }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /products/1
  # PATCH/PUT /products/1.json
  def update

    if can_update @product.name  
      respond_to do |format|
        flash.now[:notice] = "Já existe um produto cadastrado com este nome."
        format.html { render :edit }      
      end

      return
    end

    respond_to do |format|
      if @product.update(product_params)
        format.html { redirect_to @product, notice: @product.name + ' atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @product }
      else
        format.html { render :edit }
        format.json { render json: @product.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /products/1
  # DELETE /products/1.json
  def destroy
    @product.destroy   
        
    respond_to do |format|
      format.html { redirect_to products_url, notice: @product.name + ' removido com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product
      @product = Product.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_params
      params.require(:product).permit(:name, :description, :price, :product_category_id, :image)
    end

    def exists product_name
      return Product.any?{|x| x.name == product_name}
    end

    def can_update product_name
      product = Product.where(name: product_name).first

      return product.nil? || product.id == @product.id
    end

    def check_user_permission
      render_404 if !current_user.nil? && current_user.user_type != 'manager'
    end
end
