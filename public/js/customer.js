//var host = "https://conexaoboteco.herokuapp.com";
var host = "http://localhost:3000";

$("#btn-checkin").click(function (e) {
    e.preventDefault();    
    
    if (isValid("#form-checkin")) {  
        checkin();
    } else {    
        displayError("#form-checkin", "Por favor, preencha todos os campos.");
    }
});

$("#btn-checkout").click(function (e) {
    e.preventDefault();

    if (isValid("#form-checkout")) {
        checkout();
    } else {
        displayError("#form-checkout", "Por favor, preencha todos os campos.");
    }
});

function isValid(el) {    
    var fieldsCount = $(el + " input").length;
    var validFieldsQt = 0;
    
    $(el + " input").each(function () {
        var isFilled = $(this).val() !== "";

        if (isFilled) validFieldsQt += 1;
    });
  
    return fieldsCount === validFieldsQt;
}

function displayError(el, error) {
    $(el + " .login-error").removeClass("hide").text(error);
}

function checkin() {
    $.ajax({
        url: host + "/api/v1/users/create",
        type: 'POST',
        data: {
            name: $("#name").val(),
            usertype: 0,
            order: $("#order").val(),
            table: $("#table").val()
        },
        success: function (data, status, xhr) {
            $("#form-checkin .login-error").addClass("hide").text("");
            $("#form-checkin input").val("");
        },
        error: function () {
            displayError("#form-checkin", "Não foi possível cadastrar!");
        }
    });
}

function checkout() {
    
}
