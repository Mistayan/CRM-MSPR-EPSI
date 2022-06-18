const app = new Vue({
    el: '#panier',
    alt: '#nav',
    data() { //le modèle de données
        return {
            articles: {},
            customers: {},
            select: false,
            customersSearch: "",
            articlesSearch: "",
            panier: {
                id: 0,
                customerId: 0,
                articles: {},
                totalPrix: 0,
            },
            CustomerId: -1,
            panierId: -1,
            userId: -1
        }
    },
    mounted() {
        select = false
        // Actions au chargement de la page
        this.panier.id = window.sessionStorage.getItem('panierId')
        if (!this.panier.id) {
            this.panier.id = 0;
        }
        this.panier.customerId = window.sessionStorage.getItem('customerId')
        if (!this.panier.customerId) {
            this.panier.customerId = 0;
        }
        console.log("panierId = " + this.panier.id + "\ncustomerId =" + this.panier.customerId)
        axios.get("/public/article")
            .then(response => {
                this.articles = response.data.data;
            });
        axios.get("/customer/customers")
            .then(response => {
                this.customers = response.data.data;
            });
        if (this.panier.customerId) {
            axios.get('/user/panier?customerId=' + this.panier.customerId)
                .then(response => {
                    this.setPanier(response)
                });
        }
    },
    methods: { // Methodes interactives
        setPanier(response) {
            this.panier = response.data.data;
            console.log("PanierId=" + this.panier.id + " customerId=" + this.panier.customerId)
            // console.log(this.panier)
            if (this.panier) {
                this.panier.totalPrix = this.panier.totalPrix.toFixed(2);
                if (this.panier.id >= 1) {
                    window.sessionStorage.setItem('panierId', this.panier.id);
                    window.sessionStorage.setItem('customerId', this.panier.customerId);
                }
            }
        },
        selectCustomer(customer) {
            this.panier.customerId = customer.id;
            window.sessionStorage.setItem('customerId', customer.id)
            axios.get('/user/panier?customerId=' + this.panier.customerId)
                .then(response => {
                    this.panier = response.data.data;
                    this.setPanier(response)
                });
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
            <!--Changer panier-->
            axios.post('/user/panier/article?panierId=' + this.panier.id + '&articleId=' + articleId + '&action=1')
                .then(response => {
                    if (response.data.success) {
                        <!-- Re-Charger panier après ajout-->
                        axios.get('/user/panier?customerId=' + this.panier.customerId)
                            .then(response => {
                                this.setPanier(response)
                            });
                    }
                });
        },
        enleverArticle(articleId) {
            <!-- supprimer article du panier -->
            axios.post('/user/panier/article' +
                '?panierId=' + this.panier.id +
                '&articleId=' + articleId +
                '&action=0')
                .then(response => {
                    if (response.data.success) {
                        <!-- Re-Charger panier après suppression -->
                        axios.get('/user/panier?customerId=' + this.panier.customerId)
                            .then(response => {
                                this.setPanier(response);
                            });
                    }
                });
        },
        order() {
            if (!Object(this.panier.articles).length)
                return false
            console.log(this.panier.id)
            axios.post('/user/order?panierId=' + this.panier.id + '&customerId=' + this.panier.customerId)
                .then(response => {
                    console.log(this.panier.id)
                    if (response.data.success) {
                        sessionStorage.removeItem('alconf')
                        sessionStorage.removeItem('panierId')

                        // redirection vers la page, après succès de la commande
                        window.location.replace("/customer/orders.html");
                    } else {
                        console.log("failed. Saving auto_redirect to storage")
                        sessionStorage.setItem('nav', '/user/panier.html');
                        window.alert("Must be authenticated.\nYou'll be redirected after you successfully logged-in");
                        sessionStorage.setItem('alconf', '42')
                        sessionStorage.setItem('last_status', 'failed');
                        window.location.replace("/login");
                    }
                })
                .catch(response => {
                    window.alert("HARD_failed")
                    sessionStorage.setItem('last_status', 'Hard_Failed on :' +
                        'user/order?panierId=' + this.panier.id)
                    console.timeLog(response);
                    sessionStorage.removeItem('alconf')
                    window.location.replace("/user/contact.html");
                });
        },
        confirmAction() {
            let confirmAction;
            if (!sessionStorage.getItem('alconf')) {
                <!-- Confirmer la commande-->
                confirmAction = confirm("votre commande vous satisfait ?");
                sessionStorage.setItem('alconf', '117')
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
        displayValue(key, v) {

            switch (key) {
                case "id":
                    return
                case "taille" || "distance":
                    if (v < 1) return v < 0.1 ? v * 1000 + "mm" : v * 100 + "cm"
                    else return v >= 1000 ? v / 1000 + "Km" : v + "m"
                case "poids" || "masse":
                    if (v < 1000) return v < 0.1 ? v * 100 + "mg" : v + "g"
                    else return v > 1000 ? v / 1000 + "Kg" : v > 1000000 ? v / 1000000 + "T" : v + "g"
                case "taxes":
                    return v + "% TVA"
                case "pourcentage":
                    return v + '%'
                case key.includes("prix"):
                    return parseInt(v).toFixed(2) + '€'
            }
            return v
        },
        redirect(url) {
            window.location.replace(url)
        },
        filterListArticle(article) {
            return article.label.toLowerCase().includes(this.articlesSearch.toLowerCase());
        },
        filterListCustomers(customer) {
            let id = customer.id.toString().includes(this.customersSearch)
            let fn = customer.firstName.toLowerCase().includes(this.customersSearch.toLowerCase())
            let ln = customer.lastName.toLowerCase().includes(this.customersSearch.toLowerCase())
            let ma = customer.email ? customer.email.toLowerCase().includes(this.customersSearch.toLowerCase()) : null
            let cn = customer.contactNumber ? customer.contactNumber.toLowerCase().includes(this.customersSearch.toLowerCase()) : null
            let ci = customer.address.city ? customer.address.city.toLowerCase().includes(this.customersSearch.toLowerCase()) : null
            let co = customer.address.country ? customer.address.country.toLowerCase().includes(this.customersSearch.toLowerCase()) : null
            return id ? id : fn ? fn : ln ? ln : ma ? ma : cn ? cn : ci ? ci : co;
        },
        //methods end
    }
});

