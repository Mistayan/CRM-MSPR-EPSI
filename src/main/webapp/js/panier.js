const app = new Vue({
    el: '#panier',
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
            panierId: -1
        }
    },
    mounted() {
        // Actions au chargement de la page
        this.panier.id = window.localStorage.getItem('panierId')
        if (!this.panier.id) {
            this.panier.id = 0;
        }
        this.panier.customerId = window.localStorage.getItem('customerId')
        if (!this.panier.customerId) {
            this.panier.customerId = 0;
        }
        console.log("panierId = " + this.panier.id+ "\ncustomerId =" + this.panier.customerId)
        axios.get("/public/article")
            .then(response => {
                this.articles = response.data.data;
            });
        axios.get("/public/customers")
            .then(response => {
                this.customers = response.data.data;
            });
        if (this.panier.customerId) {
            axios.get('/public/panier?customerId=' + this.panier.customerId)
                .then(response => {
                    this.setPanier(response)
                });
        }
    },
    methods: { // Methodes interactives
        updatePanier(customerId) {

        },
        setPanier(response) {
            this.panier = response.data.data;
            console.log("newPanier Id=" + this.panier.id + " cId=" + this.panier.customerId)
            console.log(this.panier)
            if (this.panier) {
                this.panier.totalPrix = this.panier.totalPrix.toFixed(2);
                if (this.panier.id >= 1) {
                    window.localStorage.setItem('panierId', this.panier.id);
                    window.localStorage.setItem('customerId', this.panier.customerId);
                }
            }
        },
        selectCustomer(customer) {
            this.panier.customerId = customer.id;
            window.localStorage.setItem('customerId', customer.id)
            axios.get('/public/panier?customerId=' + this.panier.customerId)
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
            axios.post('/public/panier/article?panierId=' + this.panier.id + '&articleId=' + articleId + '&action=1')
                .then(response => {
                    if (response.data.success) {
                        <!-- Re-Charger panier après ajout-->
                        axios.get('/public/panier?customerId='+ this.panier.customerId)
                            .then(response => {
                                this.setPanier(response)
                            });
                    }
                });
        },
        enleverArticle(articleId) {
            <!-- supprimer article du panier -->
            axios.post('/public/panier/article' +
                '?panierId=' + this.panier.id +
                '&articleId=' + articleId +
                '&action=0')
                .then(response => {
                    if (response.data.success) {
                        <!-- Re-Charger panier après suppression -->
                        axios.get('/public/panier?customerId=' + this.panier.customerId)
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
                        localStorage.removeItem('alconf')
                        localStorage.removeItem('panierId')

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
                        'user/order?panierId=' + this.panier.id)
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
                case key.includes("prix"):
                    return parseInt(value).toFixed(2) + '€'
            }
            return value
        },
        redirect(url){
            window.location.replace(url)
        },
        filterListArticle(article) {
            return article.label.toLowerCase().includes(this.articlesSearch.toLowerCase());
        },
        filterListCustomers(customer) {
            let id = customer.id.toString().includes(this.customersSearch)
            let fn = customer.firstName.toLowerCase().includes(this.customersSearch.toLowerCase())
            let ln = customer.lastName.toLowerCase().includes(this.customersSearch.toLowerCase())
            let ma = customer.email ? customer.email.toLowerCase().includes(this.customersSearch.toLowerCase()): null
            let cn = customer.contactNumber ? customer.contactNumber.toLowerCase().includes(this.customersSearch.toLowerCase()) : null
            let ci = customer.address.city ? customer.address.city.toLowerCase().includes(this.customersSearch.toLowerCase()) : null
            let co = customer.address.country ? customer.address.country.toLowerCase().includes(this.customersSearch.toLowerCase()): null
            return id ? id : fn ? fn : ln ? ln : ma ? ma : cn ? cn : ci ? ci : co;
        },
        //methods end
    }
});

