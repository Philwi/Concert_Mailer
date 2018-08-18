$(document).on('click','.submit-button-user', function(e){
  var errorLog = 'Bitte folgende Fehler beheben: \n';
  var send = true;
  if ($('#user_name').val().length < 3){
    errorLog += '\tNamen eintragen\n';
    e.preventDefault();
    send = false;
  };
  var emailVal = validateEmail($('.user_email').val());
  if (!emailVal){
    errorLog += '\tE-Mail ist nicht korrekt\n';
    e.preventDefault();
    send = false;
  };
  if (($('#user_password').val().length > 0) && ($('.user_password_confirmation').val().length == 0)){
    errorLog += '\tPasswort setzen, um Passwort zu ändern.\n';
    e.preventDefault();
    send = false;
  };
  if (($('#user_password').val().length == 0) && ($('.user_password_confirmation').val().length > 0)){
    errorLog += '\tPasswort wiederholen leer lassen, wenn das Passwort nicht geändert werden soll.\n';
    e.preventDefault();
    send = false;
  };
  if (($('#user_password').val().length > 0) && ($('.user_password_confirmation').val().length == 0) && ($('.user_current_password').val().length > 0)){
    errorLog += '\tPasswort wiederholen, um Passwort zu ändern.\n';
    e.preventDefault();
    send = false;
  };
  if (($('#user_password').val().length > 0) && ($('.user_password_confirmation').val().length > 0) && ($('.user_current_password').val().length == 0)){
    errorLog += '\tAktuelles Passwort setzen um Änderungen zu bestätigen\n';
    e.preventDefault();
    send = false;
  };
  if ($('#user_current_password').val().length == 0){
    errorLog += '\tAktuelles Passwort setzen um Änderungen zu bestätigen\n';
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
