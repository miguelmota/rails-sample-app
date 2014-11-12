class UsersController < ApplicationController

  # before filters apply to every action on controller by default
  before_filter :signed_in_user, only: [:index, :edit, :update]
  before_filter :correct_user, only: [:edit, :update]
  before_filter :admin_user, only: :destroy

  def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def index
    @users = User.paginate(page: params[:page])
  end

  def new
      @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed"
    redirect_to users_path
  end

  private
    # in helper now
    #def signed_in_user
    #  unless signed_in?
        # notice, same as flash[:notice], works for [:error] but not [:success]
        #redirect_to signin_path, notice: "Please sign in." unless signed_in?

        #store_location
        #redirect_to signin_path, notice: "Please sign in"
      #end
    #end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
