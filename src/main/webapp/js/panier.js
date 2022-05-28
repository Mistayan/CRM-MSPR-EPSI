// Yag (suite) aan
// Redis BDD

const app = new Vue({
    el: '#panier',
    data() { //le modèle de données
        return {
            articles: [],
            panier: {},
            panierId: -1,
            buffer: {}
        }
    },
    mounted() {
        // Actions au chargement de la page
        this.panierId = window.localStorage.getItem('panierId');
        if (this.panierId === null) {
            this.panierId = -1;
        }
        axios.get("/public/article")
            .then(response => {
                this.articles = response.data.data;
            });
        axios.get('/public/panier?panierId=' + this.panierId)
            .then(response => {
                this.panier = response.data.data;
                if (this.panier) {
                    this.panier.totalPrix = this.panier.totalPrix.toFixed(2);
                    this.panierId = this.panier.id;
                }
            });
    },
    methods: { // Methodes interactives
        setPanier(response) {
            this.panier = response.data.data;
            if (this.panier) {
                this.panier.totalPrix = this.panier.totalPrix.toFixed(2);
                if (this.panier.id >= 1) {
                    this.panierId = this.panier.id
                }
            }

        },
        articleInPanier(article_) {
            return this.countArticleInCart(article_.id) > 0
        },
        countArticleInCart(articleId) {
            if (!this.panier || !this.panier.articles)
                return 0
            let i = 0;
            let count = 0;
            while (i < this.panier.articles.length) {
                let article = Object(this.panier.articles.at(i)) //on récupère l'objet article à l'index i
                if (articleId === article.id) {
                    count++
                }
                i++;
            }
            return count;
        },
        calc_price_article_panier(article) {
            return (article.prix * this.countArticleInCart(article.id)).toFixed(2);
        },
        ajouterArticle(articleId) {
            <!--Charger panier-->
            axios.post('/public/panier/article?panierId=' + this.panierId + '&articleId=' + articleId + '&action=1')
                .then(response => {
                    if (response.data.success) {
                        localStorage.setItem('panierId', response.data.data);
                        <!-- Re-Charger panier après ajout-->
                        axios.get('/public/panier?panierId=' + response.data.data)
                            .then(response => {
                                this.setPanier(response)
                            });
                    }
                });
        },
        enleverArticle(articleId) {
            <!-- supprimer article du panier -->
            axios.post('/public/panier/article' +
                '?panierId=' + this.panierId +
                '&articleId=' + articleId +
                '&action=0')
                .then(response => {
                    if (response.data.success) {
                        <!-- Actualiser le localstorage -->
                        localStorage.setItem('panierId', response.data.data);
                        <!-- Re-Charger panier après suppression -->
                        axios.get('/public/panier?panierId=' + response.data.data)
                            .then(response => {
                                this.setPanier(response);
                            });
                    }
                });
        },
        order() {
            console.log(this.panierId)
            axios.post('/user/order?panierId=' + this.panierId)
                .then(response => {
                    console.log(this.panierId)
                    if (response.data.success) {
                        localStorage.removeItem('alconf')
                        // redirection vers la page, après succès de la commande
                        window.location.replace("/user/orders.html");
                    } else {
                        console.log("failed. Saving auto_redirect to storage")
                        localStorage.setItem('nav', '/public/panier.html');
                        window.alert("Must be authenticated.\nYou'll be redirected after you successfully logged-in");
                        localStorage.setItem('alconf', '42')
                        localStorage.setItem('last_status', 'failed');
                        window.location.replace("/login");
                    }
                })
                .catch(response => {
                    window.alert("HARD_failed")
                    localStorage.setItem('last_status', 'Hard_Failed on :' +
                        'user/order?panierId=' + this.panier.panierId)
                    console.timeLog(response);
                    localStorage.removeItem('alconf')
                    window.location.replace("/public/contact.html");
                });
        },
        confirmAction() {
            let confirmAction;
            if (!localStorage.getItem('alconf')) {
                <!-- Confirmer la commande-->
                confirmAction = confirm("votre commande vous satisfait ?");
                localStorage.setItem('alconf', '117')
            } else {
                confirmAction = true;
            }
            <!--Commander le panier-->
            if (confirmAction) { <!--Commander le panier-->
                <!--alerte popup-->
                // window.alert("confirmer votre commande");
                this.order();
            } else {
                console.log("Action canceled by user");
            }
        }
    }
});
