var app = new Vue({
    el: '#register',
    data() {
        return {
            user: {}
        }
    },
    mounted() {
    },
    methods: {
        register() {
            axios.post('/public/register', this.user)
                .then(response => {
                    console.log(response)
                });
        }
    }
});