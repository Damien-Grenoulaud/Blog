# frozen_string_literal: true

class AuthenticationController < ApplicationController
  def login
    @user = User.new
  end
  def search
    @user = User.all.where "mail ='#{params[:mail]}' AND password_digest='#{params[:password]}' "
    
    @user = User.new(mail: "test@test.com")

    render :login, status: :unprocessable_entity
  end
end
