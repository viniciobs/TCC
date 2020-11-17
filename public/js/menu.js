var swiper = new Swiper('.swiper-container', 
{    
    slideToClickedSlide: true,   
    centeredSlides: true,
    centeredSlidesBounds: true,
    slidesPerView: 3,
    spaceBetween: 0,
    freeMode: false,     
    loop: true,            
    pagination: 
    { 
        el: ".swiper-pagination",
        clckable: true
    }
});

$('.food-menu .item a').click(function(e) { e.preventDefault(); });


