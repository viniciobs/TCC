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

$('.add').click(function()
{
   var form = $(this).closest("form");

   if (!hasQuantity(form)) return false;

   var product = $(this).data("product");

    $.ajax(
    {
        type : 'POST', 
        url : form.attr('action'),
        data : form.serialize(),
        encode : true,
        success: function (data) 
        { 
            notify(product, true); 
            $(form)[0].reset();
        },
        error: function (jqXHR, textStatus, errorThrown) { notify(product, false); }
    });
});

function hasQuantity(form)
{
    return form.find('input:visible').val() > 0;
}

function notify(product, success)
{
    $.notify(
    { 
        message: success ? product + ' foi adicionado ao carrinho' : 'Não foi possível adicionar ' + product , 
        icon: success ? 'glyphicon glyphicon-ok' : 'glyphicon glyphicon-remove',
    },
    {
        element: 'body',  
        position: null,      
        type: success ? 'success' : 'warning',
        allow_dismiss: true,
        showProgressbar: false,
        placement: {
            from: "top",
            align: "right"
        },
        offset: 10,
        spacing: 10,
        z_index: 1031,
        delay: 3000,
        timer: 1000,
        animate: {
            enter: 'animated fadeInDown',
            exit: 'animated fadeOutUp'
        },
        icon_type: 'class',
        template: '<div class="notify"><button type="button" aria-hidden="true" class="close" data-notify="dismiss">×</button><br><h4><span data-notify="icon"></span> {2}</h4></div>'               
    });
}





