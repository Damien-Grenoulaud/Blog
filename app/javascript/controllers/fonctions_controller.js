import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    changeValueForm(event){
        
        var idArticle = event.target.value;
        if(document.getElementById("listeArticlesValid").value != ""){
            document.getElementById("listeArticlesValid").value += "|";
        }
        document.getElementById("listeArticlesValid").value = idArticle;
        if(document.getElementById("listeArticlesNonValid").value != ""){
            document.getElementById("listeArticlesNonValid").value += "|";
        }
        document.getElementById("listeArticlesNonValid").value += idArticle;
        console.log(document.getElementById("listeArticlesNonValid").value);
    }
}

