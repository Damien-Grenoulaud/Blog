# frozen_string_literal: true

class ApplicationController < ActionController::Base
  before_action :set_current_user

  def set_current_user
    @current_user = User.find_by_id(session[:current_user_id])

    Current.user = @current_user
    Current.user = @current_user
    Current.user = @current_user
  end

  def login_relocate_obligatory
    redirect_to welcome_index_path, alert: 'Accés refusé' unless @current_user
  end
end
