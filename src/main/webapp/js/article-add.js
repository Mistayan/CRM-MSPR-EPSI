var app = new Vue({
    el: '#app',
    data() {
        return {
            article: {}
        }
    },
    mounted() {

    },
    methods: {

        submit() {
            axios.post('/user/article', this.article)
                .then(response => {
                });
        }

    }
});
