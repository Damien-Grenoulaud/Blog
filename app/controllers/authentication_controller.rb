# frozen_string_literal: true

class AuthenticationController < ApplicationController
  def login
    @user = User.new
  end
  def search
    @user = User.find_by(mail: params[:user][:mail]).try(:authenticate, params[:user][:password]) || User.new
    
    if @user.id
      flash[:notice] = "C est valide"

      render :login, status: :see_other
    else
      flash[:notice] = "Identifiant / mot de passe incorrect"
      render :login, status: :unprocessable_entity
    end
  end
end
