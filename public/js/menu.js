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

$(".item-quantity span").click(function()
{
    var input = $(this).parent('.item-quantity').find('input');

    if ($(this).hasClass('plus'))
    {
        input.val(parseInt(input.val()) + 1); 
    }
    else if (input.val() > 0)
    {
        input.val(parseInt(input.val()) - 1);    
    }
});


