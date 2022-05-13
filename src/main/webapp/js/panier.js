var app = new Vue({
    el: '#app',
    data() { //le modèle de données

        return {
            pizzas: [],
            panier: {}
        }
    },
    mounted() { // Ce qui est affiché au chargement de la page
        axios.get("/public/pizza")
            .then(response => {this.pizzas = response.data.data;});
        let panier_id = localStorage.getItem('panier_id');
        axios.get('/public/panier?panier_id=' + panier_id)
            .then(response => {this.panier = response.data.data});
    },
    methods: { // Methodes interactives
        ajouterPizza(pizza) {
            <!--Cookie panier-->
            let panier_id = localStorage.getItem('panier_id');
            if (!panier_id) { panier_id = -1;}
            <!--Charger panier-->
            axios.post('/public/panier/pizza?panier_id='+panierId+'?pizza_id='+pizza.id)
                .then(response => {
                    if (reponse.data.success){
                        localStorage.setItem('panier.id', response.data.data);
                        <!-- Re-Charger panier après ajout ou suppression-->
                        axios.get('/public/panier?panier_id='+response.data.data)
                            .then(response => {this.panier = response.data.data;});
                    }
                });
        }

    }
});