const app = new Vue({
    el: '#app',
    data() {

        return {
            newUser: {
                role: null,
                email: null,
                password: null
            },
            role_user: null,
            role_comm: null
        }

    },
    mounted() { //action au chargement de la page
    },
    methods: { // Methodes intéractives

        createUser() {
            if (this.role_user ^ this.role_comm) { //Soit l'un, soit l'autre mais pas les deux
                this.newUser.role = this.role_user ? "ROLE_USER" : "ROLE_COMM";
            } else {
                console.log('error')
                return;
            }
            axios.post('/admin/register', this.newUser)
                .then(response => {
                    if (response.data.success) {
                        this.newUser = {};
                        axios.get("/admin/register")
                            .then(response => {
                                this.user = response.data.data;
                            });
                    }
                });
        }
    }
});