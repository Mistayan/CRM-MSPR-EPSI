// Yag (suite) aan
// Redis BDD

const app = new Vue({
    el: '#app',
    data() { //le modèle de données
        return {
            pizzas: [],
            panier: {},
            panier_id: -1
        }
    },
    mounted() {
        // Actions au chargement de la page
        this.panier_id = window.localStorage.getItem('panier.id');
        if (this.panier_id === null) {
            this.panier_id = -1;
        }
        axios.get("/public/pizza")
            .then(response => {
                this.pizzas = response.data.data
            });
        axios.get('/public/panier?panier_id=' + this.panier_id)
            .then(response => {
                this.panier = response.data.data;
                if (this.panier)
                    this.panier.totalPrix = this.panier.totalPrix.toFixed(2);
            });
    },
    methods: { // Methodes interactives
        setPanier(response) {
            this.panier = response.data.data;
            if (this.panier)
                this.panier.totalPrix = this.panier.totalPrix.toFixed(2);
        },
        ajouterPizza(pizza_id) {
            <!--Charger panier-->
            axios.post('/public/panier/pizza?panier_id=' + this.panier_id + '&pizza_id=' + pizza_id + '&action=1')
                .then(response => {
                    if (response.data.success) {
                        localStorage.setItem('panier.id', response.data.data);
                        <!-- Re-Charger panier après ajout-->
                        axios.get('/public/panier?panier_id=' + response.data.data)
                            .then(response => {
                                this.setPanier(response)
                            });
                    }
                });
        },
        panierContainsPizza() {
            if (this.panier && this.panier.pizzas && this.panier.pizzas.length > 0) {
                return true
            }
            return false
        },
        pizzaInPanier(pizza_) {
            if (this.countPizzaInCart(pizza_.id) > 0) {
                return true
            }
        },
        countPizzaInCart(pizza_id) {
            if (!this.panier || !this.panier.pizzas)
                return 0;
            let i = 0;
            let count = 0;
            while (i < this.panier.pizzas.length) {
                let pizza = Object(this.panier.pizzas.at(i))
                let pizza2 = this.panier.pizzas.at(i)
                if (pizza_id === pizza.id) {
                    count++
                }
                i++;
            }
            return count;
        },
        enleverPizza(pizza_id) {
            <!-- supprimer pizza du panier -->
            axios.post('/public/panier/pizza' +
                '?panier_id=' + this.panier_id +
                '&pizza_id=' + pizza_id +
                '&action=0')
                .then(response => {
                    if (response.data.success) {
                        <!-- Actualiser le localstorage -->
                        localStorage.setItem('panier.id', response.data.data);
                        <!-- Re-Charger panier après suppression -->
                        axios.get('/public/panier?panier_id=' + response.data.data)
                            .then(response => {
                                this.setPanier(response);
                            });
                    }
                });
        },
        order() {
            console.log(this.panier_id)
            axios.post('/user/order?panier_id=' + this.panier_id)
                .then(response => {
                    console.log(this.panier_id)
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
                        'user/order?panier_id=' + this.panier.panier_id)
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
                localStorage.setItem('alconf', '42')
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
