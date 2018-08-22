<template lang="pug">
  .form-for-bookers
    .text-center
      img(src="~images/concert.jpg")
    .input-for-bookers
      p(v-if="errors.length")
        br
        ul
          li(v-for="error in errors" style="color: white;") {{ error }}
      template(v-if="state == 'notCreated'")
        b-form(@submit="onSubmit")
          input.form-control(type='text' v-model='stadt' autofocus='true' placeholder='Stadt' required="true")
          input.form-control(type='text' v-model='club' autofocus='true' placeholder='Club' required="true")
          input.form-control(type='text' v-model='email' autofocus='true' placeholder='E-Mail' required="true")
          input.form-control(type='text' v-model='homepage' autofocus='true' placeholder='Website')
          input.form-control(type='text' v-model='name' autofocus='true' placeholder='Kontaktperson')
          input.form-control(type='text' v-model='telefon' autofocus='true' placeholder='Telefon')
          input.form-control(type='text' v-model='bundesland' autofocus='true' placeholder='Bundesland')
          input.form-control(type='text' v-model='land' autofocus='true' placeholder='Land' required="true")
          input.form-control(type='text' v-model='plz' autofocus='true' placeholder='PLZ')
          center
            b-button(type="submit" style="margin: 35px; background-color: #00426e !important; border-radius: 25px; padding: 8px 25px;")
              | Hinzufügen
      template(v-if="state == 'wait'")
        deliverQuestion
      template(v-if="state == 'success'")
        successForm
      template(v-if="state == 'fail'")
        failForm


</template>

<script>
import deliverQuestion from './deliverQuestion.vue';
import failForm from './failForm.vue';
import successForm from './successForm.vue';
import { eventBus} from './../../application';
import 'images/concert.jpg'
export default {
  components:{
    deliverQuestion,
    failForm,
    successForm
  },
  name: 'panelform',
  props: {
    data: {
    }
  },
  data() {
    return {
      stadt: '',
      club: '',
      email: '',
      homepage: '',
      name: '',
      telefon: '',
      bundesland: '',
      land: '',
      plz: '',
      state: 'notCreated',
      getResponse: '',
      errors: []
    };
  },
  methods: {
    closePanel() {
      this.$emit('closePanel', {
        name: this.form.name
      });
    },
    onSubmit(e){
      e.preventDefault();
      if (this.validEmail(this.email)){
        this.state = 'wait';
      } else {
        this.errors.push('Bitte eine gültige E-Mail eintragen');
      }
    },
    validEmail(email) {
      var re = /^(([^<>()\[\]\\.,;:\s@"]+(\.[^<>()\[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/;
      return re.test(email);
    },
  },
  watch: {
    state: function(){
      if (this.state == 'wait'){
        console.log("hallo")
        var csrf = (document.querySelector('meta[name="csrf-token"]').getAttribute('content'));
        var formData = new FormData();
        formData.append("stadt", this.stadt );
        formData.append("club", this.club );
        formData.append("email", this.email );
        formData.append("homepage", this.homepage );
        formData.append("name", this.name );
        formData.append("telefon", this.telefon );
        formData.append("bundesland", this.bundesland);
        formData.append("land", this.land );
        formData.append("plz", this.plz );
        formData.append("authenticity_token", csrf);
        this.$http.post( '/bookers', formData).then(response => {
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
  max-height: 300px;
}
.form-for-bookers ::placeholder{
  color:rgba(255,255,255,0.4) !important;
  text-transform: uppercase;
}
.input-for-bookers{
  top: 2%;
  position: relative;
  margin: 0 5%;
}
</style>
