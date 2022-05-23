const orders = new Vue({
    el: '#orders',
    data() { //le modèle de données
        return {
            orders: []
        }
    },
    mounted() {
        // Actions au chargement de la page
        this.panierId = window.localStorage.getItem('panier.id');
        if (this.panierId === null) {
            this.panierId = -1;
        }
        axios.get("/user/orders")
            .then(response => {
                this.orders = response.data.data
                }
            );
        methods: {

        }

    }
})
