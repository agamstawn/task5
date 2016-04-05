class UsersController < ApplicationController
  def index
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    @user = User.new(params_user)
    User.transaction do
      if @user.save
        begin
          ConfirmationMailer.confirm_email("#{@user.email}", @user.activation_token).deliver
        rescue
          if ActiveRecord::Rollback
            flash[:error] = "confirmation email failed"
            redirect_to root_url
          else
            flash[:notice] = "activation instruction has send to #{@user.email}"
            redirect_to root_url
          end
        end
        redirect_to root_path
      else
        flash[:error] = "data not valid"
        render "new"
      end
    end
  end

  private
  def params_user
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
