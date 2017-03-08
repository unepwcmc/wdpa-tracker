class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authenticate_admin!

  def index
    @users = User.all.order(:last_name).page(params[:page] || 1)

    respond_to do |format|
      format.json { render json: @users.to_json(methods: :full_name) }
      format.html { }
    end
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to users_path, notice: "The user was successfully updated"
    else
      render :edit
    end
  end

  def create
    if @user = User.create(user_params)
      redirect_to users_path, notice: "The user was successfully created"
    else
      render :new
    end
  end

  def destroy
    user = User.find(params[:id])
    user.destroy

      redirect_to users_path, notice: "The user was successfully deleted"
  end

  private

  def user_params
    params.require(:user).permit(
      :email,
      :password,
      :password_confirmation,
      :first_name,
      :last_name,
      :role_id
    )
  end

  def authenticate_admin!
    if current_user.role.name != "Admin"
      redirect_to :root
    end
  end
end

