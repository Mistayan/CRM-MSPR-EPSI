const nav = new Vue({
    el: '#head',
    mounted() {
        // Si une redirection était en cours, elle se poursuivra
        if (window.sessionStorage.getItem('nav')) {
            let link = window.sessionStorage.getItem('nav');
            sessionStorage.removeItem('nav')
            window.location.replace(link)
        }
        axios.get("/public/auth")
            .then(response => {
                if (!response.data.success || !response.data.data) {
                    return
                }
                document.body.insertAdjacentHTML("#head", `
    
`)
            })
    }
});
