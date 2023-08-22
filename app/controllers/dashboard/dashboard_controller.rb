# frozen_string_literal: true

class Dashboard::DashboardController < ApplicationController
  before_action :verif_user_admin

  
  def verif_user_admin
    redirect_to welcome_index_path, alert: "Accés refusé" unless @current_user&.admin?
  end
  
end
