const customerOrders = new Vue({
    el: '#customer-orders',
    data() { //le modèle de données
        return {
            orders: [],
            articlesRepo: [],
            totalArticles: 0,
            totalPrixHT: 0.0,
            totalPrixTTC: 0.0,
            customerId: -1
        }
    },
    mounted() {
        // Actions au chargement de la page
        this.customerId = parseInt(window.sessionStorage.getItem('customerId'))
        if (!this.customerId) {
            this.customerId = -1;
        }
        console.log(this.customerId)
        if (this.customerId >= 1) {
            console.log(this.customerId)
            axios.get("/customer/orders?customerId=" + this.customerId)
                .then(response => {
                    this.orders = Object(response.data.data)
                    let i = 0;
                    while (i < this.orders.length) { // pour chaque commande de la liste
                        let order = this.orders.at(i) // pour l'objet 'order' à l'index en cours
                        this.totalPrixTTC += order.prixTTC;
                        this.totalPrixHT += order.prixHT;
                        this.totalArticles += order.articles.length;
                        i++
                    }
                    this.totalPrixTTC.toFixed(2)
                    this.totalPrixHT.toFixed(2)
                });
        }
        axios.get("/user/article")
            .then(response => {
                this.articlesRepo = response.data.data
            });
    },
    methods: {
        countArticleInOrder(articleId, order) {
            let count = 0
            let i = 0;
            while (i < Object(order.articles).length) { // on ne peut pas appeler length sans Object()
                let pid = Object(order.articles.at(i)).id // on ne peut pas appeler id sans Object()
                if (pid === articleId)
                    count += 1
                i++
            }
            return count
        },
        calc_price_articles_order(article, order) {
            return (article.prix * this.countArticleInOrder(article.id, order)).toFixed(2)
        },
        displayPrice(val) {
            return parseFloat(val).toFixed(2) + '€'
        },
    }
})
