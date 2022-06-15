const app = new Vue({
    el: '#app',
    data() { //le modèle de données

        return {
            articles: [],
            categories: [],
            properties: [],
            create: false,
            modify: false,
            select: null,
            newArticle: {
                category: {id: -1},
                properties: {id: -1},
                stats: {id: -1},
                status: true,
            },
            newCat: [],
            search: "",
        }
    },
    mounted() { // Ce qui est fait au chargement de la page
        axios.get("/admin/article")
            .then(response => {
                this.articles = response.data.data;
            });
        axios.get("/admin/categories")
            .then(response => {
                this.categories = response.data.data
            });
        // axios.get("/admin/properties")
        //     .then(response => {
        //         this.properties = response.data.data
        //     });
    },
    methods: { // Methodes intéractives
        createArticle() {
            // concat
            this.newArticle.category = {};
            this.newArticle.category.id = this.newCat[0];
            // console.log(this.newArticle)

            axios.post('/admin/article/new', this.newArticle)
                .then(response => {
                    if (response.data.success) {
                        this.newArticle = {
                            category: {id: -1},
                            properties: {id: -1},
                            stats: {id: -1}
                        };
                        this.create = this.modify = this.select = false;
                        axios.get("/admin/article")
                            .then(response => {
                                this.articles = response.data.data;
                            });
                    }
                });
        },
        modifyArticle: function () {
            console.log(this.newArticle)

            axios.post('/admin/article/modify', this.newArticle)
                .then(response => {
                    if (response.data.success) {
                        this.resetValues()
                        this.create = this.modify = this.select = false;
                        axios.get("/admin/article")
                            .then(response => {
                                this.articles = response.data.data;
                            });
                    }
                });
        },
        switchArticle(stat) {
            newArticle.status = stat
            console.log(this.newArticle)
            axios.post('/admin/article/switch', this.newArticle)
                .then(response => {
                    if (response.data.success) {
                        this.resetValues()
                        this.create = this.modify = this.select = false;
                        axios.get("/admin/article")
                            .then(response => {
                                this.articles = response.data.data;
                            });
                    }
                });
        },
        resetValues() {
            this.newArticle = {
                category: {id: -1},
                properties: {id: -1},
                stats: {id: -1}
            }
        }
    }
});