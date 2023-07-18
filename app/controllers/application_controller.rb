# frozen_string_literal: true

class ApplicationController < ActionController::Base
    before_action :set_current_user
    public

    # TODO sans regarder le code de la fonction, cette fonction pour moi verifie un login qui est en soit un fomulaire identifiant mot de passe non ?
    # or cette fonction definie le current_user, ce serait mieux de le nommer par exemple:
    # set_current_user, ou define_current_user .... ?
    def set_current_user
        @current_user = User.find_by_id(session[:current_user_id])
    end
    def login_relocate_obligatory
        if @current_user.nil?
            flash[:notice] = "Attention vous n'avez pas le droit d'accéder à cette page"
            redirect_to welcome_index_path
        end
    end
end
