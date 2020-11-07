class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index  
    @users = User.all
    @users = @users.filter_by_type(params[:type]) if params[:type].present?
    @users = @users.filter_by_name(params[:name]) if params[:name].present?
    @users = @users.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if exists @user.username 
      respond_to do |format|
        flash.now[:notice] = "Já existe um usuário cadastrado com este login."
        format.html { render :edit }      
      end

      return
    end

    respond_to do |format|
      if @user.save                      
        format.html { redirect_to @user, notice: @user.name + ' cadastrado com sucesso.' }
        format.json { render :show, status: :created, location: @user }         
      else
        format.html { render :new }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: @user.name + ' atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy   
        
    respond_to do |format|
      format.html { redirect_to users_url, notice: @user.name + ' removido com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:name, :username, :user_type, :password, :password_confirmation)
    end

    def exists username
      return User.any?{|x| x.username == username}
    end
end
