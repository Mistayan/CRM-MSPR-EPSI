var app = new Vue({
    el: '#app',
    data() {
        return {
            articles: []
        }
    },
    mounted() {
        axios.get('/public/articles')
            .then(response => {
                this.articles = response.data;
            });
    },
    methods: {

        displayArticle(article) {
            //window.location = '/user/article.html?code=' + article.code
            console.log(article.code)
        }

    }
});
