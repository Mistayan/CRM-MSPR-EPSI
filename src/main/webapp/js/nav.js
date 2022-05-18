const nav = new Vue({
    el: '#app',
    mounted() {
        if (window.localStorage.getItem('nav')) {
            let link = window.localStorage.getItem('nav');
            localStorage.removeItem('nav')
            window.location.replace(link);
        }
    }
});