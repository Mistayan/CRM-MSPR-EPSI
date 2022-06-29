const userApp = new Vue({
    el: '#userApp',
    data() { //le modèle de données

        return {
            users: {},
            roles: [],
            search: "",
            role_user: false,
            role_comm: false,
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

        createUser: function () {
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
        modifyUser: function () {
            console.log(this.newUser)
            this.newUser.role = this.role_user ? "ROLE_USER" : this.role_comm ? "ROLE_COMM" : "ROLE_NOONE"
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
        },
        filterListUsers: function (user) {
            let em = user.email.toLowerCase().includes(this.search.toString().toLowerCase())
            let ro = user.role ? user.role.toString().includes(this.search.toString()) : null
            return em ? em : ro;
        },
    }
});