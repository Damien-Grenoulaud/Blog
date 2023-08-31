import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    changeValueForm(event){
        var idArticle = event.target.getAttribute("data-article")
        if(event.target.checked){
            
            if(document.getElementById("article_listeArticlesValid").value != ""){
                document.getElementById("article_listeArticlesValid").value += "|";
            }
            document.getElementById("article_listeArticlesValid").value += idArticle;
            if(document.getElementById("article_listeArticlesNonValid").value != ""){
                document.getElementById("article_listeArticlesNonValid").value += "|";
            }
            document.getElementById("article_listeArticlesNonValid").value += idArticle;
            console.log(document.getElementById("article_listeArticlesNonValid").value);
        }
        else{
            document.getElementById("article_listeArticlesValid").value = document.getElementById("article_listeArticlesValid").value.replace(idArticle+"|","")
            document.getElementById("article_listeArticlesValid").value = document.getElementById("article_listeArticlesValid").value.replace("|"+idArticle,"")
            document.getElementById("article_listeArticlesValid").value = document.getElementById("article_listeArticlesValid").value.replace(idArticle,"")



            document.getElementById("article_listeArticlesNonValid").value = document.getElementById("article_listeArticlesNonValid").value.replace(idArticle+"|","")
            document.getElementById("article_listeArticlesNonValid").value = document.getElementById("article_listeArticlesNonValid").value.replace("|"+idArticle,"")
            document.getElementById("article_listeArticlesNonValid").value = document.getElementById("article_listeArticlesNonValid").value.replace(idArticle,"")
        }
        
    }
}

