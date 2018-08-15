<template lang="pug">
  .message
    .row
      .col.col-md-1
      .col.col-md-10
        select(v-model="selected" placeholder="Wähle deine Band aus")
          option(value="" disabled selected style="color:rgba(255,255,255,0.4) !important;")
            p Wähle deine Band aus
          option(v-for= "band in bands" v-bind:value="band.id")
            p {{ band.name }}
        b-form(@submit='onSubmit')
          b-form-input(v-model="subject" placeholder="Betreff" required='')
          br
          wysiwyg(v-model='body' style='background-color: white; color: black !important; height: 400px;')
          br

</template>

<script>
import { eventBus} from './../../application'
export default {
  name: 'messageForm',
  components: {
  },
  data() {
    return {
      body: '',
      subject: '',
      bands: [],
      selected: ''
    }
  },
  methods: {
    fetchBands(){
      fetch('bands.json')
      .then((res) => { return res.json()})
      .then((res) => { this.bands = res })
    },
    onSubmit (evt) {
      evt.preventDefault();
      alert(JSON.stringify(this.form));
    },
  },
  watch: {
    body: function(){
      eventBus.$emit('body', this.body);
    },
    subject: function(){
      eventBus.$emit('subject', this.subject);
    },
    selected: function(){
      eventBus.$emit('band', this.selected);
    }


  },
  created() {
    this.fetchBands();
  }
}
</script>

<style>
.message input{
  border: none !important;
  outline: none !important;
  background: none !important;
  border-bottom: 2px solid rgba(255,255,255,0.6) !important;
  border-radius: 0 !important;
  text-align: center !important;
  color: white !important;
  font-weight: 600 !important;

}
.message ::placeholder{
  color:rgba(255,255,255,0.4) !important;
  text-transform: uppercase;
}
.message select{
  border: none;
  background: none;
  padding: 5px 0;
  width: 100%;
  color: white;
  text-align: center;
  text-transform: uppercase;
  font-weight: 600
}
</style>
