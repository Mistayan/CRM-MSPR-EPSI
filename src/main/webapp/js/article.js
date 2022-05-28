const app = new Vue({
    el: '#app',
    data() { //le modèle de données

        return {
            articles: [],
            ingredients: [],
            create: false,
            newArticle: {},
            newIngredient: {}
        }
    },
    mounted() { // Ce qui est affiché au chargement de la page
        axios.get("/admin/article")
            .then(response => {
                this.articles = response.data.data;
            });
    },
    methods: { // Methodes intéractives

        createArticle() {
            axios.post('/admin/article/new_article', this.newArticle)
                .then(response => {
                    if (response.data.success) {
                        this.newArticle = {};
                        this.newIngredient = {};
                        this.create = false;
                        axios.get("/admin/article")
                            .then(response => {
                                this.articles = response.data.data;
                            });
                    }
                });
        }
    }
});