const order = new Vue({
    el: '#order',
    data() { //le modèle de données
        return {
            orders: [],
            pizzasRepo: [],
            totalPizza: 0,
            totalPrixHT: 0.00,
            totalPrixTTC: 0.00,
            totalCalories: 0
        }
    },
    mounted() {
        // Actions au chargement de la page
        axios.get("/user/orders")
            .then(response => {
                this.orders = Object(response.data.data)
                let i = 0;
                while (i < this.orders.length) { // pour chaque commande de la liste
                    let order = this.orders.at(i) // pour l'objet 'order' à l'index en cours
                    this.totalPrixTTC += order.prixTTC;
                    this.totalPrixHT += order.prixHT;
                    this.totalPizza += order.pizzas.length;
                    i++
                }
            });
        axios.get("/public/pizza")
            .then(response => {
                this.pizzasRepo = response.data.data
            });
    },
    methods: {
        countPizzaInOrder(pizzaId, order) {
            let count = 0
            let i = 0;
            while (i < Object(order.pizzas).length) { // on ne peut pas appeler length sans Object()
                let pid = Object(order.pizzas.at(i)).id // on ne peut pas appeler id sans Object()
                if (pid === pizzaId)
                    count += 1
                i++
            }
            return count
        },
        calc_price_pizzas_order(pizza, order) {
            return (pizza.prix * this.countPizzaInOrder(pizza.id, order)).toFixed(2)
        }
    }
})
