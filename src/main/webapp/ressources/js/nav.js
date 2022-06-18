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
            console.log('test')
            if (this.link.contains('index.html') || this.link === '/' || this.link === "/#") {
                console.log('test')
                window.sessionStorage.clear()
            }
            if (window.sessionStorage.getItem('last_status') === 'fail') {
                console.log('move')
                window.sessionStorage.removeItem('last_status')
                window.location.replace(this.link)
            }
        } else {
            window.sessionStorage.setItem('nav', window.location.href)
        }
        axios.get("/public/auth")
            .then(response => {
                if (!response.data.success || !response.data.data) {
                    // window.location.replace("/login")
                    window.alert("...")
                }
            })
    },
    methods: {
        redirect: function () {
            this.link = window.sessionStorage.getItem('nav');
            window.location.replace(this.link)

        }
    }
});
