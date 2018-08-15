<template lang='pug'>
  .failForm
    center
      i.fa.fa-times-circle.fa-5x(style="color: red;padding: 30px;")
      br
      b Deine Mails konnten leider nicht verschickt werden. Bitte stelle sicher, dass du eine Nachricht und einen Betreff verfasst hast!


</template>
<script>
export default {
  name: 'failForm',
  created(){
    setTimeout(function(){
      window.location.replace("/");
    }, 4000)

  }
}
</script>
