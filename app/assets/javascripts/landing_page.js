$(document).on('click','.signUpSubmit', function(e){
  alert();
  var errorLog = 'Bitte folgende Fehler beheben: \n';
  var send = true;
  if ($('#user_name').val().length < 4){
    errorLog += '\tNamen eintragen mit mindestens 4 Buchstaben.\n';
    e.preventDefault();
    send = false;
  };
  var emailVal = validateEmail($('.signUpEmail').val());
  if (!emailVal){
    errorLog += '\tE-Mail ist nicht korrekt\n';
    e.preventDefault();
    send = false;
  };
  if ($('.signUpPassword').val().length < 6){
    errorLog += '\tPasswort mit mindestens 6 Buchstaben setzen!\n';
    e.preventDefault();
    send = false;
  };
  if (send == false){
    alert(errorLog);
  };
  function validateEmail(email) {
    var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
    return re.test(String(email).toLowerCase());
  };
})
