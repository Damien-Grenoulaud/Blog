# frozen_string_literal: true

class ApplicationController < ActionController::Base
    before_action :veriflogin
    public

    # TODO sans regarder le code de la fonction, cette fonction pour moi verifie un login qui est en soit un fomulaire identifiant mot de passe non ?
    # or cette fonction definie le current_user, ce serait mieux de le nommer par exemple:
    # set_current_user, ou define_current_user .... ?
    def veriflogin
        @current_user = User.find_by_id(session[:current_user_id])
    end
end
