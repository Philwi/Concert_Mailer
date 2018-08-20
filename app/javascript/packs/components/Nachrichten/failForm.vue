<template lang='pug'>
  .failForm
    center
      i.fa.fa-times-circle.fa-5x(style="color: red;padding: 30px;")
      br
      p Deine Mails konnten leider nicht verschickt werden. Bitte stelle sicher, dass du eine Nachricht und einen Betreff verfasst hast!
      p Wenn noch doppelte E-Mail Einträge vorhanden sind, können auch keine Nachrichten verschickt werden. Schaue dazu bitten in die News und korrigiere die Einträge. Wenn du der Meinung bist, dass es keine doppelten E-Mails mehr gibt, dann schicke mir über das Kontakt-Formular eine Nachricht.


</template>
<script>
export default {
  name: 'failForm',
  created(){
    setTimeout(function(){
      window.location.replace("/");
    }, 10000)

  }
}
</script>
