class UsersController < ApplicationController
  before_action :authenticate_user!

  def edit
    @user=User.find(params[:id])
    @user.create_profile unless @user.profile
    binding.pry
  end
  def update

    @user=User.find(params[:id])
    if @user.update(user_params)
      redirect_to edit_user_path(@user)
    else
      render :edit
    end
  end
  def show
    @user=User.find(params[:id])
  end
  private
  def user_params
    params.require(:user).permit(:email,:profile_attributes=> [:id,:legal_name,:birthday,:location,:education,:occupation,:bio,:specialty])
  end
end
