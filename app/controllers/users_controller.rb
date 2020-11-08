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

  # GET /users/1/edit
  def edit
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
      params.require(:user).permit(:user_type, :active)
    end    
end
