const app = new Vue({
    el: '#app',
    data() { //le modèle de données

        return {
            pizzas: [],
            ingredients: [],
            create: false,
            newPizza: {},
            newIngredient: {}
        }
    },
    mounted() { // Ce qui est affiché au chargement de la page
        axios.get("/admin/pizza")
            .then(response => {
                this.pizzas = response.data.data;
            });
        axios.get("/admin/ingredients")
            .then(response => {
                this.ingredients = response.data.data;
            });
    },
    methods: { // Methodes intéractives

        addIngredients() {
            if (!this.newPizza.ingredients) {
                this.newPizza.ingredients = [];
            }
            if (this.newIngredient !== "") {
                this.newPizza.ingredients.push(this.newIngredient);
            }
            this.newIngredient = {};
        },

        createPizza() {
            axios.post('/admin/pizza/new_pizza', this.newPizza)
                .then(response => {
                    if (response.data.success) {
                        this.newPizza = {};
                        this.newIngredient = {};
                        this.create = false;
                        axios.get("/admin/pizza")
                            .then(response => {
                                this.pizzas = response.data.data;
                            });
                    }
                });
        }
    }
});