const nav = new Vue({
    el: '#nav',
    mounted() {
        if (window.sessionStorage.getItem('nav')) {
            let link = window.sessionStorage.getItem('nav');
            sessionStorage.removeItem('nav')
            window.location.replace(link)
        } else {
            let link = "/index.html";
            window.location.replace(link)
        }
    }
});