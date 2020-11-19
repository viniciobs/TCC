class ProductCategoriesController < ApplicationController
  before_action :set_product_category, only: [:show, :edit, :update, :destroy]
  before_action :check_user_permission

  # GET /product_categories
  # GET /product_categories.json
  def index
    @product_categories = ProductCategory.all
  end

  # GET /product_categories/1
  # GET /product_categories/1.json
  def show
  end

  # GET /product_categories/new
  def new
    @product_category = ProductCategory.new
  end

  # GET /product_categories/1/edit
  def edit
  end

  # POST /product_categories
  # POST /product_categories.json
  def create
    @product_category = ProductCategory.new(product_category_params)

    if exists @product_category.name
      respond_to do |format|
        format.html { redirect_to @product_category, notice: "Já existe uma categoria cadastrada com este nome." }
        format.json { render :edit, status: :unprocessable_entity, location: @product_category }
      end

      return
    end

    respond_to do |format|
      if @product_category.save
        format.html { redirect_to @product_category, notice: 'A categoria ' + @product_category.name + ' foi criada com sucesso.' }
        format.json { render :show, status: :created, location: @product_category }
      else
        format.html { render :new }
        format.json { render json: @product_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /product_categories/1
  # PATCH/PUT /product_categories/1.json
  def update
    respond_to do |format|
      if @product_category.update(product_category_params)
        format.html { redirect_to @product_category, notice: 'A categoria ' +  @product_category.name + ' foi atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @product_category }
      else
        format.html { render :edit }
        format.json { render json: @product_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /product_categories/1
  # DELETE /product_categories/1.json
  def destroy    
    
    if has_order_associated
      respond_to do |format|
        format.html { redirect_to product_categories_url, notice: 'Não é possível remover a categoria pois há produtos da mesma que estão associados a uma comanda.' }
        format.json { head :no_content }
      end 

      return
    end
    message = @product_category.destroy ? 'A categoria ' +  @product_category.name + ' foi removida com sucesso.' : 'Ocorreram erros que impediram a categoria de ser removida.'

    respond_to do |format|
      format.html { redirect_to product_categories_url, notice: message }
      format.json { head :no_content }
    end    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_product_category
      @product_category = ProductCategory.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def product_category_params
      params.require(:product_category).permit(:name)
    end

    def exists product_category_name
      return ProductCategory.any?{|x| x.name == product_category_name}
    end

    def check_user_permission
      render_404 if !current_user.nil? && current_user.user_type != 'manager'
    end
    
    def has_order_associated
      return false if @product_category.products.empty?

      @product_category.products.each do |product|
        return true if product.has_order_associated
      end

      return false
    end
end
