<template lang="pug">
  .mailing
    .pagination-for-mailing
      .progressbar-nachrichten
        center
          b-progress(:max="max" :value="counter" class="w-50 mb-3" height="25px" style="margin-bottom: 0 !important")
        .ul.list-inline
          .li.list-inline-item(style="margin-right: 5%" @click="table")
            p.inline Kontakte
          .li.list-inline-item(style="margin-right: 5%" @click="message")
            p.inline Nachricht
          .li.list-inline-item( @click="deliver")
            p.inline Abschicken
    keep-alive
      template(v-if="state == 'table'")
        tableBookers
      template(v-if="state == 'message'")
        messageForm
      template(v-if="state == 'deliver'")
        deliverQuestion
      template(v-if="state == 'success'")
        successForm
      template(v-if="state == 'fail'")
        failForm
</template>

<script>
import tableBookers from './components/Nachrichten/Table.vue';
import messageForm from './components/Nachrichten/messageForm.vue';
import deliverQuestion from './components/Nachrichten/deliverQuestion.vue';
import successForm from './components/Nachrichten/successForm.vue';
import failForm from './components/Nachrichten/failForm.vue';
import { eventBus} from './application';
export default {
  name: 'Nachrichten',
  components: {
    tableBookers,
    messageForm,
    deliverQuestion,
    successForm,
    failForm
  },
  data() {
    return {
      max: 100,
      counter: 100/3,
      state: 'table',
      body: '',
      subject: '',
      band: '',
      bookers: [],
      getResponse: ''
    }
  },
  methods: {
    table() {
      this.counter = 100/3 * 1;
      this.state = 'table';
    },
    message() {
      this.counter = 100/3 * 2;
      this.state = 'message';
    },
    deliver() {
      this.counter = 100/3 * 3;
      this.state = 'deliver';
    },
  },
  created(){
    eventBus.$on('body', (data) => {
      this.body = data;
    });
    eventBus.$on('subject', (data) => {
      this.subject = data;
    });
    eventBus.$on('bookers', (data) => {
      this.bookers = data;
    });
    eventBus.$on('band', (data) => {
      this.band = data;
    });
  },
  watch:
  {
    state: function(){
      if (this.state == 'deliver'){
        var bookers = new Array();
        var i;
        for (i = 0; i < this.bookers.length; i++){
          bookers.push(this.bookers[i]["id"]);
        }
        var csrf = (document.querySelector('meta[name="csrf-token"]').getAttribute('content'));
        var formData = new FormData();
        formData.append('band', this.band);
        formData.append('body', this.body);
        formData.append('subject', this.subject);
        formData.append('veranstalter', bookers);
        formData.append("authenticity_token", csrf);
        this.$http.post( 'mailings/mailing', formData).then(response => {
          this.getResponse = true;
        }, response => {
          this.getResponse = false;
        });
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

  }
}

</script>


<style>

.pagination-for-mailing{
  text-align: center !important;
}
.pagination-for-mailing p{
  font-family: 'Amatic SC';
  text-transform: uppercase;
  font-size: 27px;
  font-weight: 600;
  cursor: pointer;
}

.pagination-progressbar{

}
.progress-bar{
  background-color: #2B0764 !important;
  margin-bottom: 0px;

}
.mailing{
  color: white;
}

</style>
