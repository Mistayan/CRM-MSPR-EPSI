const app = new Vue({
    el: '#app',
    data() {
        //le modèle de données
        return {
            pizzas: [],
            panier: {},
            panier_id: -1
        }
    },
    mounted() {
        // Actions au chargement de la page
        if (!isNaN(parseInt(window.localStorage.getItem('panier.id')))) {
            this.panier_id = window.localStorage.getItem('panier.id');
        }
        axios.get('/public/panier?panier_id=' + this.panier_id)
            .then(response => {
                this.panier = response.data.data
            });
        axios.get("/public/pizza")
            .then(response => {
                this.pizzas = response.data.data;
            });
    },
    methods: { // Methodes intéractives
        ajouterPizza(pizza) {
            <!--Charger panier-->
            axios.post('/public/panier/pizza?panier_id=' + this.panier_id + '&pizza_id=' + pizza.id + '&action=1')
                .then(response => {
                    if (response.data.success) {
                        localStorage.setItem('panier.id', response.data.data);
                        <!-- Re-Charger panier après ajout-->
                        axios.get('/public/panier?panier_id=' + response.data.data)
                            .then(response => {
                                this.panier = response.data.data;
                            });
                    }
                });
        }
    }
});