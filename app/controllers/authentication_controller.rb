# frozen_string_literal: true

class AuthenticationController < ApplicationController
  def login
    @user = User.new
  end

  def logout
    session.clear
    redirect_to login_path, notice: 'Vous êtes déconnecté'
  end

  def search
    @user = User.find_by(mail: params[:user][:mail]).try(:authenticate,
                                                         params[:user][:password]) || User.new(login_params)

    if @user.id
      flash[:notice] = 'C est valide'
      session[:current_user_id] = @user.id
      set_current_user
      render :login, status: :see_other

    else
      flash[:alert] = 'Identifiant / mot de passe incorrect'
      render :login, status: :unprocessable_entity
    end
  end

  private

  def login_params
    params.require(:user).permit(
      :mail,
      :password
    )
  end
end
