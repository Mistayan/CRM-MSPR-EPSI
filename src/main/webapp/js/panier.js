const app = new Vue({
    el: '#panier',
    data() { //le modèle de données

        return {
            customerId: -1,
            articles: [],
            customers: [],
            panierId: -1,
            panier: {},
            filtered: {},
            buffer: {},
            input: ""
        }
    },
    mounted() {
        // Actions au chargement de la page
        this.panierId = window.localStorage.getItem('panierId');
        if (this.panierId === null) {
            this.panierId = -1;
        }
        this.customerId = window.localStorage.getItem('currentCustomerId');
        if (this.customerId === null) {
            this.customerId = -1;
        }
        // Si un customer a précédemment été selectionné par l'utilisateur,
        // on chargera le contenu nécessaire pour faire une commande
        // (on lui laisse la possibilité de changer de client)
        if (this.customerId !== -1) {
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
                        window.localStorage.setItem('panierId', this.panierId);
                    }
                });
            axios.get("/public/customers")
                .then(response => {
                    this.customers = response.data.data;
                });
        } else {
            // Sinon, seule la liste des clients sera chargée.
            axios.get("/public/customers")
                .then(response => {
                    this.customers = response.data.data;
                });
        }
    },
    methods: { // Methodes interactives
        setPanier(response) {
            this.panier = response.data.data;
            if (this.panier) {
                this.panier.totalPrix = this.panier.totalPrix.toFixed(2);
                if (this.panier.id >= 1) {
                    this.panierId = this.panier.id
                    window.localStorage.setItem('panierId', this.panierId);
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
            if (!Object(this.panier).length)
                return false
            console.log(this.panierId)
            axios.post('/user/order?panierId=' + this.panierId + '&customerId=' + this.customerId)
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
        },
        displayValue(key, value) {

            switch (key) {
                case "id":
                    return
                case "taille" || "distance":
                    if (value < 1) return value < 0.1 ? value * 1000 + "mm" : value * 100 + "cm"
                    else return value >= 1000 ? value / 1000 + "Km" : value + "m"
                case "poids" || "masse":
                    if (value < 1000) return value < 0.1 ? value * 100 + "mg" : value + "g"
                    else return value > 1000 ? value / 1000 + "Kg" : value > 1000000 ? value / 1000000 + "T" : value + "g"
                case "taxes":
                    return value + "% TVA"
                case "pourcentage":
                    return value + '%'
            }
            return value
        },
        filterList() {
            return this.articles.filter((article) =>
                article.label.toLowerCase().includes(input.value.toLowerCase())
            );
        },//methods end
    }
});

