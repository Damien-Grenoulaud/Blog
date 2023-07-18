# frozen_string_literal: true

class ApplicationController < ActionController::Base
    before_action :getCurrentUser
    public
    def getCurrentUser
        @current_user = User.find_by_id(session[:current_user_id])
    end
    def loginRelocateObligatory
        if @current_user.nil?
            flash[:notice] = "Attention vous n'avez pas le droit de créer un article"
            redirect_to welcome_index_path
        else
            return true
        end
    end
end
