$(".btn").click(function(e){
    e.preventDefault();
    
    if (isValid())
    {
        tryRegister();
    }
    else
    {
       displayError("Por favor, preencha todos os campos.");         
    }
});

function isValid()
{
    var fieldsCount = $(".form-signin input").length;
    var validFieldsQt = 0;
    
    $(".form-signin input").each(function(){
        var isFilled = $(this).val() != "";
        
        if (isFilled) validFieldsQt += 1;
    });
        
    return fieldsCount == validFieldsQt;
}

function displayError(error)
{
    $(".login-error").removeClass("hide").text(error);   
}

function getIdentifier()
{
    var pageUrl = window.location.search.substring(1);
    var urlVars = pageUrl.split('&');
    
    if (urlVars.length !== 1) 
    {
        displayError("Não foi possível resgatar o identificador da sua conta.\nContate o administrador.");
    }
    else
    {
       return urlVars[0].split('=')[1];
    }
}

function tryRegister()
{
    var identifier = getIdentifier();
    
    if (typeof id !== undefined || id !== '')
    {
        $.ajax({
//       url: "https://conexaoboteco.herokuapp.com/api/v1/users/create",
           url: "http://localhost:3000/api/v1/users/create",
           type: 'POST',
           data: { id: identifier, login: $("#inputLogin").val(), password: $("#inputPassword").val() },
           success: function (data, status, xhr){     
               document.cookie = "USER_HASH=" + data; 
               redirect();
           },
           error: function ()
           {
               displayError("Não foi possível cadastrar!");
           }
       });
    }   
}