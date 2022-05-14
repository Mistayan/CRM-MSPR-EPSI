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
        axios.get("/public/pizza")
            .then(response => {
                this.pizzas = response.data.data
            });
        console.log("Table des pizzas");
        console.log(this.pizzas);
        // let panier_id = localStorage.getItem('panier_id');
        axios.get('/public/panier?panier_id=' + this.panier_id)
            .then(response => {
                this.panier = response.data.data
            });
        console.log("Infos panier");
        console.log(this.panier);
    },
    methods: { // Methodes interactives
        enleverPizza(pizza_panier_index) {
            console.log(pizza_panier_index);
            <!--supprimer pizza du panier-->
            axios.post('/public/panier/pizza' +
                '?panier_id=' + this.panier_id +
                '&pizza_id=' + pizza_panier_index +
                '&action=0')
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