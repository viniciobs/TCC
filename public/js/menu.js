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


$('.swiper-wrapper .item a').on('click', function(e)
{    
    e.preventDefault();

    $('.swiper-wrapper .item a').each(function(){
        $(this).removeClass('active');
    });

    $(this).addClass('active');
}); 