<template lang="pug">
  .form-for-bookers
    .text-center
      img(src="~images/delete.jpg")
    .input-for-bookers
      template(v-if="state == 'wait'")
        deliverQuestion
      template(v-if="state == 'success'")
        successForm
      template(v-if="state == 'fail'")
        failForm
      template(v-if="state == 'notCreated'")
        b-form(@submit="onSubmit")
          center
            h5(style="color: white; margin-top: 20px;") Soll wirklich {{ bookers.club }} in {{ bookers.stadt }} gelöscht werden?
            br
        .row
          wysiwyg(v-model='kommentar' style='background-color: white; color: black !important; height: 200px; max-width: 400px;' placeholder="Wenn ja, warum?")
        center
          b-button(type="submit" style="margin: 35px; background-color: red; !important; border-radius: 25px; padding: 8px 25px;" @click="onSubmit")
            | Löschen



</template>

<script>
import deliverQuestion from './deliverQuestion.vue';
import failForm from './failForm.vue';
import successForm from './successForm.vue';
import { eventBus} from './../../application';
import 'images/edit.jpg'
export default {
  components:{
    deliverQuestion,
    failForm,
    successForm
  },
  name: 'deletepanel',
  props: ['booker'],
  data() {
    return {
      state: 'notCreated',
      getResponse: '',
      bookers: [],
      kommentar: ''
    };
  },
  beforeUpdate: function(){
  },
  methods: {
    closePanel() {
      this.$emit('closePanel', {
        name: this.form.name
      });
    },
    onSubmit(e){
      e.preventDefault();
      this.state = 'wait'
    },
    fetchBooker(){
      fetch('bookers/' + this.booker +'.json')
      .then((res) => { return res.json() })
      .then((res) => { this.bookers = res })
    }
  },
  created: function(){
    this.fetchBooker();
  },
  watch: {
    state: function(){
      if (this.state == 'wait'){
        var csrf = (document.querySelector('meta[name="csrf-token"]').getAttribute('content'));
        var formData = new FormData();
        formData.append("id", this.booker);
        formData.append("active", 'false');
        formData.append("kommentar", this.kommentar)
        formData.append("authenticity_token", csrf);
        this.$http.patch( '/bookers/update/' + this.booker, formData).then(response => {
          this.getResponse = true;
        }, response => {
          this.getResponse = false;
        });
      }
      if (this.state== 'success'){
        eventBus.$emit('state', this.state);
      }
    },
    getResponse: function(){
      if (this.getResponse == true){
        setTimeout(function(){
          this.state = 'success';
        }.bind(this), 400)
      }else if(this.getResponse == false){
        setTimeout(function(){
          this.state = 'fail';
        }.bind(this), 2000)
      }
    }
  },
};
</script>

<style>
.form-for-bookers{
  background-color: #0bc443;
  height: 100%;
  overflow-x:hidden;
}

.form-for-bookers *{
}
.form-for-bookers input{
  border: none !important;
  outline: none !important;
  background: none !important;
  border-bottom: 1px solid rgba(255,255,255,0.6) !important;
  border-radius: 0 !important;
  text-align: center !important;
  font-weight: 600 !important;
  margin-top: 10px;
  color: white !important;
}
.form-for-bookers img{
  width: 100%;
}
.form-for-bookers ::placeholder{
  color:rgba(255,255,255,0.4) !important;
  text-transform: uppercase;
}
.input-for-bookers{
  top: 2%;
  position: relative;
}
</style>
