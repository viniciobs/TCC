$('.alter-status').click(function()
{
	var form = $(this).closest('form');
	updateStatus(form);
});

function updateStatus(form)
{
	$.ajax(
    {
        type : 'POST', 
        url : form.attr('action'),
        data : form.serialize(),
        encode : true,
        always: setInterval(function(){ document.location.reload(true); }, 1000)     
    });
}