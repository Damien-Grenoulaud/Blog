# frozen_string_literal: true

module ArticlesHelper
    def verif_status_actif(status)
        if status.actif?
            "bg-lime-400"
        else
            "bg-neutral-400"
        end
    end
    def verif_status_inactif(status)
        if status.inactif?
            "bg-red-600"
        else
            "bg-neutral-400"
        end
    end
end
