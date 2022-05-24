const order = new Vue({
    el: '#order',
    data() { //le modèle de données
        return {
            orders: [],
            pizzasRepo: [],
            totalPizza: 0,
            totalPrixHT: 0,
            totalPrixTTC: 0,
            totalCalories: 0
        }
    },
    mounted() {
        // Actions au chargement de la page
        axios.get("/user/orders")
            .then(response => {
                    this.orders = Object(response.data.data)
                    let i = 0;
                    while (i < this.orders.length) {
                        let order = this.orders.at(i)
                        this.totalPrixTTC += order.prixTTC;
                        this.totalPizza += order.pizzas.length;
                        this.totalPrixHT += order.prixHT;
                        i++
                    }
                }
            );
        axios.get("/public/pizza")
            .then(response => {
                this.pizzasRepo = response.data.data
            });
    },
    methods: {
        // countPizzaInOrder(pizzaId){
        //     let count = 0
        //     for (let _pizza in Object(this.orders.pizzas)){
        //         if (_pizza.id === pizzaId)
        //             count += 1
        //     }
        //     return count
        // },
        // calc_price_pizzas_order(pizza) {
        //     return (pizza.prix * this.countPizzaInOrder(pizza.id)).toFixed(2)
        // }
    }
})
