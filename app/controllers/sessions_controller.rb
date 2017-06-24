class SessionsController < ApplicationController

  def new
  end

  def create
    @user = User.find_by_email(params[:email])

    if @user.present?
      if @user.authenticate(params[:password])
        session[:user_id] = @user.id
        flash[:success] = "Welcome back #{@user.name}"

        redirect_to messages_path
      else
        flash.now[:error] = "Incorrect password or email!"
        render 'new'
      end
    else
      flash.now[:error] = "Accound doesn't exist!"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to new_session_path
  end

end
