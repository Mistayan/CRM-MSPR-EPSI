var app = new Vue({
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
        axios.get("/public/pizza")
            .then(response => {
                this.pizzas = response.data.data
            });
        axios.get('/public/panier?panier_id=' + this.panier_id)
            .then(response => {
                this.panier = response.data.data
                this.panier.totalPrix = this.panier.totalPrix.toFixed(2);
            });

    },
    methods: { // Methodes interactives
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
                                this.panier = response.data.data;
                                this.panier.totalPrix = this.panier.totalPrix.toFixed(2);
                            });
                    }
                });
        },
        order() {


        },
        confirmAction() {
            let confirmAction;
            if (!localStorage.getItem('alconf')){
                <!-- Confirmer la commande-->
                confirmAction = confirm("Are you sure you want to order this cart ?");
                //TODO
                // localStorage.removeItem('alconf')
            }
            else {
               confirmAction = true;
            }
            if (confirmAction) {
                <!--alerte popup-->
                // window.alert("confirmer votre commande");
                <!--Commander le panier-->
                axios.post('/user/order?panier_id=' + this.panier_id)
                    .then(response => {
                        console.log(this.panier_id)
                        if (response.data.success) {
                            // redirection vers la page
                            // window.location.replace("/user/orders.html");
                        } else {
                            console.log("failed. Saving auto_redirect to storage")
                            localStorage.setItem('nav', '/user/panier.html');
                            window.alert("Must be authenticated.\nYou'll be redirected after you successfully logged-in");
                            localStorage.setItem('alconf', '42')
                            window.location.replace("/login");
                        }
                    })
                    .catch(response => {
                        console.log("HARD_failed")
                        window.location.replace("/public/contact.html");
                    });
            } else {
                console.log("Action canceled by user");
            }
        }
    }
});