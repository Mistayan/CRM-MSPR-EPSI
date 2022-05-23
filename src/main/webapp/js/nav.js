const nav = new Vue({
    el: '#nav',
    mounted() {
        if (window.localStorage.getItem('nav')) {
            let link = window.localStorage.getItem('nav');
            localStorage.removeItem('nav')
            window.location.replace(link)
        } else {
            let link = "/index.html";
            window.location.replace(link)
        }
    }
});