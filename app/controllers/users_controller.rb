# encoding: UTF-8
class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Użytkownik dodany pomyślnie."
      redirect_to users_path
    else
      render 'new'
    end
  end

  def index
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :name, :password, :password_confirmation)
    end
end
