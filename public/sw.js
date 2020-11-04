var cacheName = "conexao-boteco";
var filesToCache = [
    "/",
    "menu.html",
    "live-music.html",
    "orders.html",
    "css/default-style.css",    
    "css/menu.css",
    "js/menu.js"
];

self.addEventListener('install', function(e){
    e.waitUntill(
        cashes.open(cacheName).then(function(cache){
            return cache.addAll(filesToCache);
        })
    );
});

self.addEventListener('fetch', function(e){
    e.respondWith(
        caches.match(e.request).then(function(response){
            return response || fetch(e.request);      
        })
    );
})