# frozen_string_literal: true

class AuthenticationController < ApplicationController
  def login
    @user = User.new
  end
  def search
    @user = User.all.where "mail ='#{params[:mail]}' AND password_digest='#{params[:password]}' "
    puts @user
  end
end
