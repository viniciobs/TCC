class UsersController < ApplicationController
	before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :check_user_permission, except: [:inactive]

  # GET /users
  # GET /users.json
  def index  
    @users = User.where('id<>?', current_user.id)
    @users = @users.filter_status(params[:status]) if params[:status].present?
    @users = @users.filter_by_type(params[:type]) if params[:type].present?
    @users = @users.filter_by_name(params[:name]) if params[:name].present?
    @users = @users.filter_by_scheduled_today if params[:scheduled_today].present?
    @users = @users.paginate(:page => params[:page], :per_page => 10)
  end

  # GET /user/1
  # GET /user/1.json
  def show
  end

  # GET /users/1/inactive
  # GET /users/1/inactive.json
  def inactive
  end

  # GET /users/1/edit
  def edit
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update      
 
    respond_to do |format|
      if @user.update(user_params)

        if @user.scheduled_today
          User.all.filter_by_scheduled_today.where.not(id: @user.id).each do |u|
            u.scheduled_today = false 
            u.save 
          end
        end

        create_order(@user) if @user.active?

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

    def create_order user
      order = Order.new
      order.user_id = user.id
      order.table_num = params[:table_num]

      order.save
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_user      
      @user = User.find(params[:id]) 
    end

    # Only allow a list of trusted parameters through.
    def user_params
      params.require(:user).permit(:user_type, :active, :scheduled_today)
    end    

     def check_user_permission
      render_404 if !current_user.nil? && current_user.user_type != 'manager'
    end
end
