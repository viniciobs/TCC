$("input.rating").change(function() 
{	
	var form = $(this).closest("form");

	$.ajax(
	{
        type : 'POST', 
        url : form.attr('action'),
        data : form.serialize(),
        encode : true
    });	
});