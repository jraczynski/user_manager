# encoding: UTF-8
class UsersController < ApplicationController
  helper_method :sort_column, :sort_direction

  def index
    @users = User.search(params[:search],params[:select_column]).order(sort_column + " " + sort_direction).paginate(per_page: 20, page: params[:page])
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user
    else
      render 'edit'
    end
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

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = "Użytkownik usunięty."
    redirect_to users_url
  end

  private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :name, :password, :password_confirmation)
    end

    def sort_column
      User.column_names.include?(params[:sort]) ? params[:sort] : "last_name"
    end
  
    def sort_direction
      %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
    end
end
