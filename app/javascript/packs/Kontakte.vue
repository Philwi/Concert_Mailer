<template lang="pug">
#booker

  slideout-panel
    panelform

  //input.form-control(type='text' v-model='stadt' autofocus='true' placeholder='Stadt')
  //input.form-control(type='text' v-model='club' autofocus='true' placeholder='Club')
  //input.form-control(type='text' v-model='email' autofocus='true' placeholder='E-Mail')
  //input.form-control(type='text' v-model='homepage' autofocus='true' placeholder='Website')
  //input.form-control(type='text' v-model='name' autofocus='true' placeholder='Kontaktperson')
  //input.form-control(type='text' v-model='telefon' autofocus='true' placeholder='Telefon')
  //input.form-control(type='text' v-model='bundesland' autofocus='true' placeholder='Bundesland')
  //input.form-control(type='text' v-model='land' autofocus='true' placeholder='Land')
  //input.form-control(type='text' v-model='plz' autofocus='true' placeholder='PLZ')

  .searchButtons
    .row
      .col-md-4
        form
          input.form-control(type='text' v-model='searchCity' autofocus='true' placeholder='Stadt')
      .col-md-4
        form
          input.form-control(type='text' v-model='searchClub' autofocus='true' placeholder='Club')
      .col-md-4
        form
          input.form-control(type='text' v-model='searchBundesland' autofocus='true' placeholder='Bundesland')
  br
  .bookerTable
    .row
      .col-md-12
        table.table.table-borderless
          thead
            tr
              th Stadt
              th Club
              th E-Mail
              th Bundesland
              th Land
              th
                center
                  i.fa.fa-plus.fa-2x(@click="showPanel1()")
          tbody
            tr(v-for='(booker) in paginatedData')
              td  {{ booker.stadt }}
              td  {{ booker.club }}
              td  {{ booker.email }}
              td  {{ booker.bundesland }}
              td  {{ booker.land }}
              td
                center
                  i.fa.fa-pencil.fa-2x(@click='editbooker(booker.id)' style='margin-right: 10%')
                  i.fa.fa-trash.fa-2x(@click='deletebooker(booker.id)')

    .row
      .col-md-4
      .col-md-4
        center
          i.fa.fa-chevron-circle-left.fa-2x(@click='prevPage' style='margin-right: 15px')
          b {{ pageNumber }}
          i.fa.fa-chevron-circle-right.fa-2x(@click='nextPage' style='margin-left: 15px')


</template>
<script>
import { vueSlideoutPanelService } from 'vue2-slideout-panel';
import panelform from './panelform.vue';
export default {
  name: 'booker',
  components: {
    panelform
  },
  data() {
    return {
      searchCity: '',
      searchClub: '',
      searchBundesland: '',
      bookers: [],
      booker: '',
      pageNumber: 0,
      pageRecordSize: 10,
    }
  },
  created() {
    this.fetchbooker();
  },
  methods: {
    fetchbooker() {
      fetch('bookers.json')
      .then((res) => { return res.json() })
      .then((res) => { this.bookers = res })
    },
    addbooker() {
      this.$http.post('bookers.json', {title: this.booker}, {})
        .then((res) => this.fetchbooker(), this.booker = '')
        .catch((error) => console.log('Got a problem' + error));
    },
    deletebooker(booker_id) {
      this.$http.delete('bookers/' + booker_id)
        .then((res) => this.fetchbooker())
        .catch((error) => console.log('Got a problem' + error));
    },
    toggleEdit: function(ev, booker) {
      this.$http.put('bookers/' + booker.id, {editable: true})
        .then((res) => this.fetchbooker())
    },
    editbooker(booker) {
      this.$http.put('bookers/' + booker.id, {editable: false, title: booker.name })
        .then((res) => this.fetchbooker())
    },
    nextPage(){
      this.pageNumber++;
    },
    prevPage(){
      if (this.pageNumber > 0){
      this.pageNumber--;
      }
    },
    showPanel1() {
      vueSlideoutPanelService.show({
          component: 'panelform',
          width: '500px', //customize the width
          cssClass: 'panel-1-custom-class', //add a custom CSS class
          props: {
            data: {
            }
          }
        })
        .then(results => {
          console.log('Results for panel 1:', results);
        });
    }
  },
  computed: {
    filteredList(){
      return this.bookers.filter( booker => {
        if ((this.searchCity == '') && (this.searchClub == '') && (this.searchBundesland == '')){
          return booker}
        else if ((booker.stadt !== null) && (this.searchClub == '')&& (this.searchBundesland == '')){
          return booker.stadt.toLowerCase().includes(this.searchCity.toLowerCase())
        }
        else if ((booker.bundesland !== null) && (this.searchClub == '')&& (this.searchCity == '')){
          return booker.bundesland.toLowerCase().includes(this.searchBundesland.toLowerCase())
        }
        else if ((booker.club !== null) && (this.searchCity == '')&& (this.searchBundesland == '')){
          return booker.club.toLowerCase().includes(this.searchClub.toLowerCase())
        }
        else if ((booker.club !== null) && (booker.city !== null) && (this.searchCity != '') && (this.searchClub != '')&& (this.searchBundesland == '')){
          return booker.club.toLowerCase().includes(this.searchClub.toLowerCase()) && booker.stadt.toLowerCase().includes(this.searchCity.toLowerCase())
        }
        else if ((booker.club !== null) && (booker.bundesland !== null) && (this.searchBundesland != '') && (this.searchClub != '')&& (this.searchCity == '')){
          return booker.club.toLowerCase().includes(this.searchClub.toLowerCase()) && booker.bundesland.toLowerCase().includes(this.searchBundesland.toLowerCase())
        }
        else if ((booker.bundesland !== null) && (booker.city !== null) && (this.searchCity != '') && (this.searchBundesland != '') && (this.searchClub == '')){
          return booker.bundesland.toLowerCase().includes(this.searchBundesland.toLowerCase()) && booker.stadt.toLowerCase().includes(this.searchCity.toLowerCase())
        }
        else if ((booker.bundesland !== null) && (booker.city !== null) && (booker.club !== null) && (this.searchCity != '') && (this.searchBundesland != '') && (this.searchClub != '')){
          return booker.bundesland.toLowerCase().includes(this.searchBundesland.toLowerCase()) && booker.stadt.toLowerCase().includes(this.searchCity.toLowerCase()) && booker.club.toLowerCase().includes(this.searchClub.toLowerCase())
        }
      })
    },
    pageCount(){
      var l = this.filteredList.length,
          s = this.pageRecordSize;
      return Math.floor(l/s);
    },
    paginatedData(){
      const start = this.pageNumber * this.pageRecordSize,
            end = start + this.pageRecordSize;
      return this.filteredList.slice(start, end);
    },
  },
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
th{
  font-weight: 700;
  text-transform: uppercase;
}
table{
  background-image: linear-gradient(to left, #051937, #00426e, #006f8b, #009c7b, #0bc443);
}
thead{
}
tbody{

}

.bookerTable{
  -webkit-box-shadow: 10px 10px 38px 0px rgba(0,0,0,0.75) !important;
  -moz-box-shadow: 10px 10px 38px 0px rgba(0,0,0,0.75) !important;
  box-shadow: 10px 10px 38px 0px rgba(0,0,0,0.75) !important;
}


.searchButtons input{
  border: none !important;
  outline: none !important;
  background: none !important;
  border-bottom: 2px solid rgba(255,255,255,0.6) !important;
  border-radius: 0 !important;
  text-align: center !important;
  color: white !important;
  font-weight: 600 !important;
}
.searchButtons ::placeholder{
  color:rgba(255,255,255,0.4) !important;
  text-transform: uppercase;
}
</style>
