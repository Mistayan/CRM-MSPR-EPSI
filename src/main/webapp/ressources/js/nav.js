const nav = new Vue({
    alt: '#nav-item',
    el: '#nav',
    data() { //le modèle de données
        return {
            auth: null,
            link: null,
            select: false
        }
    },
    mounted() {
        // Si une redirection était en cours, elle se poursuivra
        if (window.sessionStorage.getItem('nav')) {
            this.link = window.sessionStorage.getItem('nav');
            if (this.link.contains('index.html') || this.link === '/' || this.link === "/#") {
                window.sessionStorage.clear()
            }
            if (window.sessionStorage.getItem('last_status') === 'fail') {
                window.sessionStorage.removeItem('last_status')
                window.location.replace(this.link)
            }
        } else { // Sinon, on enregistre l'addresse actuelle, en cas dé déconnexion
            window.sessionStorage.setItem('nav', window.location.href)
        }
        axios.get("id")
            .then(response => {
                    this.userId = response.data.data;
                    window.sessionStorage.setItem("userId", response.data.data)
                }
            );
        axios.get("/public/auth")
            .then(response => {
                if (!response.data.success || !response.data.data) {
                    window.location.replace("/login")
                }
                console.log(response.data.data)
            });
    },
    methods: {
        redirect: function () {
            this.link = window.sessionStorage.getItem('nav');
            window.location.replace(this.link)
        }
    }
});
