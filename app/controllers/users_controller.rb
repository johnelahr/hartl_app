class UsersController < ApplicationController
  def new
  	@user = User.new
  end

  def show
  	@user = User.find(params[:id])
  end

  def create
  	@user = User.new((permit_params))
  	if @user.save
      flash[:success] = "Weclome to the sample app"
  		redirect_to @user
  	else
  		render 'new'
  	end
  end

  private

  def permit_params
  	params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
