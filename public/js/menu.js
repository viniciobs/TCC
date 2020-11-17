var swiper = new Swiper('.swiper-container', 
{    
    centeredSlides: true,
    centeredSlidesBounds: true,
    slidesPerView: 3,
    spaceBetween: 0,
    freeMode: false,     
    loop: true,            
    pagination: 
    { 
        el: ".swiper-pagination",
        clickable: true 
    }
});

$('.food-menu .item a').click(function(e){ e.preventDefault(); });


