<template lang='pug'>
  .successForm
    center
      i.fa.fa-check-circle.fa-5x(style="color: white;padding: 30px;")

</template>
<script>
export default {
  name: 'successForm',
  created(){
    setTimeout(function(){
      window.location.replace("/");
    }, 2000)

  }
}
</script>
