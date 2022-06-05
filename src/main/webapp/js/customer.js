const customerApp = new Vue({
    el: '#customerApp',
    data() { //le modèle de données

        return {
            customers: {},
            cities: [],
            countries: [],
            streetNames: [],
            create: false,
            modify: false,
            select: false,
            newCustomer: {}, // voir resetValues() pour la structure de la classe
            search: ""
        };
    },
    mounted() { // Ce qui est fait au chargement de la page
        this.resetValues()
        axios.get("/comm/customers")
            .then(response => {
                this.customers = response.data.data;
            });
        // axios.get("/public/countries")
        //     .then(response => {
        //         this.countries = response.data.data
        //     });
    },
    methods: { // Methodes intéractives

        createCustomer: function () {
            console.log(this.newCustomer)

            axios.post('/comm/customer/add', this.newCustomer)
                .then(response => {
                    if (response.data.success) {
                        this.resetValues();
                        this.create = this.modify = this.select = false;
                        axios.get("/comm/customers")
                            .then(response => {
                                this.customers = response.data.data;
                            });
                    }
                });
        },
        modifyCustomer: function () {
            console.log(this.newCustomer)

            axios.post('/comm/customer/modify', this.newCustomer)
                .then(response => {
                    if (response.data.success) {
                        this.resetValues()
                        this.create = this.modify = this.select = false;
                        axios.get("/comm/customers")
                            .then(response => {
                                this.customers = response.data.data;
                            });
                    }
                });
        },
        resetValues: function () {
            this.newCustomer = {
                firstName: "",
                lastName: "",
                contactNumber: "",
                address: {
                    country: "",
                    city: "",
                    postalCode: "",
                    wayNumber: "",
                    wayType: "",
                    wayName: "",
                }
            }
        }
    }
});