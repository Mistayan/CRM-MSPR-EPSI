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
            });

    },
    methods: { // Methodes interactives
        enleverPizza(pizza_id) {
            <!--supprimer pizza du panier-->
            axios.post('/public/panier/pizza' +
                '?panier_id=' + this.panier_id +
                '&pizza_id=' + pizza_id +
                '&action=0')
                .then(response => {
                    if (response.data.success) {
                        localStorage.setItem('panier.id', response.data.data);
                        <!-- Re-Charger panier après suppression-->
                        axios.get('/public/panier?panier_id=' + response.data.data)
                            .then(response => {
                                this.panier = response.data.data;
                            });
                    }
                });
        }
    }
});