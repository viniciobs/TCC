var swiper = new Swiper('.swiper-container', 
{
    slidesPerView: 3,
    spaceBetween: 0,
    freeMode: false,              
    pagination:{
        el: ".swiper-pagination",
        clickable: true
    },                
    loop: true,
    centeredSlides:false
});


$('.food-menu .item a').on('click', function(e)
{    
    e.preventDefault();

    $('.food-menu .item').each(function(){
        $(this).removeClass('active');
    });

    $(this).parent().addClass('active');
}); 