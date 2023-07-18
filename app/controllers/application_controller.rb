# frozen_string_literal: true

class ApplicationController < ActionController::Base
    before_action :veriflogin
    public
    def veriflogin
        @current_user = User.find_by_id(session[:current_user_id])
    end
end
