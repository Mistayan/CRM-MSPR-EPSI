// Yag (suite) aan
// Redis BDD

const app = new Vue({
    el: '#panier',
    data() { //le modèle de données
        return {
            pizzas: [],
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
        axios.get("/public/pizza")
            .then(response => {
                this.pizzas = response.data.data;
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
        ajouterPizza(pizzaId) {
            <!--Charger panier-->
            axios.post('/public/panier/pizza?panierId=' + this.panierId + '&pizzaId=' + pizzaId + '&action=1')
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
        panierContainsPizza() {
            return !!(this.panier && this.panier.pizzas && this.panier.pizzas.length > 0);

        },
        pizzaInPanier(pizza_) {
            if (this.countPizzaInCart(pizza_.id) > 0) {
                return true
            }
        },
        countPizzaInCart(pizzaId) {
            if (!this.panier || !this.panier.pizzas)
                return 0
            let i = 0;
            let count = 0;
            while (i < this.panier.pizzas.length) {
                let pizza = Object(this.panier.pizzas.at(i)) //on récupère l'objet pizza à l'index i
                if (pizzaId === pizza.id) {
                    count++
                }
                i++;
            }
            return count;
        },
        calc_price_pizza_panier(pizza) {
            return (pizza.prix * this.countPizzaInCart(pizza.id)).toFixed(2);
        },
        enleverPizza(pizzaId) {
            <!-- supprimer pizza du panier -->
            axios.post('/public/panier/pizza' +
                '?panierId=' + this.panierId +
                '&pizzaId=' + pizzaId +
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
