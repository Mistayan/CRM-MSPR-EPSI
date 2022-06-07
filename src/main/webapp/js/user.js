const userApp = new Vue({
    el: '#userApp',
    data() { //le modèle de données

        return {
            users: {},
            roles: [],
            create: false,
            modify: false,
            select: false,
            newUser: {}, // voir resetValues() pour la structure de la classe
        };
    },
    mounted() { // Ce qui est fait au chargement de la page
        this.resetValues()
        axios.get("/admin/users")
            .then(response => {
                this.users = response.data.data;
            });
        axios.get("/admin/roles")
            .then(response => {
                this.roles = response.data.data
            });
    },
    methods: { // Methodes intéractives

        createCustomer: function () {
            console.log(this.newUser)

            axios.post('/admin/user/add', this.newUser)
                .then(response => {
                    if (response.data.success) {
                        this.resetValues();
                        this.create = this.modify = this.select = false;
                        axios.get("/admin/users")
                            .then(response => {
                                this.users = response.data.data;
                            });
                    }
                });
        },
        modifyCustomer: function () {
            console.log(this.newUser)

            axios.post('/admin/user/modify', this.newUser)
                .then(response => {
                    if (response.data.success) {
                        this.resetValues()
                        this.create = this.modify = this.select = false;
                        axios.get("/admin/users")
                            .then(response => {
                                this.users = response.data.data;
                            });
                    }
                });
        },
        resetValues: function () {
            this.newUser = {
                email: "",
                password: "",
                nickname: "",
                role: "",
                dateCreated: "",
            }
        }
    }
});