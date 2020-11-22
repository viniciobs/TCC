var cacheName = "conexao-boteco";
var filesToCache = [
    "/",
    "app/views/menu.html.erb",
    "app/views/rates/dex.html.erb",
    "app/views/application.html.erb",
    "app/assets/*"
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