//var host = "https://conexaoboteco.herokuapp.com";
var host = "http://localhost:3000";

$(document).ready(function() {
    var userHash = getCookie("USER_HASH")
    if (typeof userHash !== 'undefined' && userHash !== "")
    {
       redirect(); 
    }
});

function redirect()
{
  location.href = $("#redirect-page").val();      
}

function getCookie(cname) {
  var name = cname + "=";
  var ca = document.cookie.split(';');
  for(var i = 0; i < ca.length; i++) {
    var c = ca[i];
    while (c.charAt(0) == ' ') {
      c = c.substring(1);
    }
    if (c.indexOf(name) == 0) {
      return c.substring(name.length, c.length);
    }
  }
  return "";
}

$(".btn").click(function(e){
    e.preventDefault();
    
    if (isValid())
    {
        tryLogin();
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

function tryLogin()
{
   $.ajax({
       url:  host + "/api/v1/users/validate",
       type: 'POST',
       data: { usertype: $("#user-type").val(), login: $("#inputLogin").val(), password: $("#inputPassword").val()},
       success: function (data, status, xhr){     
           document.cookie = "USER_HASH=" + data; 
           redirect();
       },
       error: function ()
       {
           displayError("Não foi possível acessar!");
       }
   });
}