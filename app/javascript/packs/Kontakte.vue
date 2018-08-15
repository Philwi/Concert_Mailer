<template lang="pug">
#booker

  slideout-panel(:booker="clickedBooker")


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
import panelform from './components/Veranstalter/panelform.vue';
import editpanelform from './components/Veranstalter/editpanelform.vue';
import deletepanel from './components/Veranstalter/deletepanel.vue';
import { vueSlideoutPanelService, VueSlideoutPanel } from 'vue2-slideout-panel';
import { eventBus } from './application';
export default {
  name: 'booker',
  components: {
    panelform,
    'slideout-panel': VueSlideoutPanel
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
      refreshTable: '',
      clickedBooker: '',
    }
  },
  created() {
    eventBus.$on('state', (data) => {
      this.refreshTable = data;
    });
    this.fetchbooker();
  },
  methods: {
    fetchbooker() {
      fetch('bookers.json')
      .then((res) => { return res.json() })
      .then((res) => { this.bookers = res })
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
          width: '400px', //customize the width
          cssClass: 'panelform-body', //add a custom CSS class
          props: {
            data: {
            }
          }
        })
        .then(results => {
          console.log('Results for panel 1:', results);
        });
    },
    editbooker(booker) {
      this.clickedBooker = booker;
      vueSlideoutPanelService.show({
          component: 'editpanelform',
          width: '400px', //customize the width
          cssClass: 'panelform-body', //add a custom CSS class
          props: {
              booker

          }
        })
        .then(results => {
          console.log('Results for panel 1:', results);
        });
    },
    deletebooker(booker){
      this.clickedBooker = booker;
      vueSlideoutPanelService.show({
          component: 'deletepanel',
          width: '400px', //customize the width
          cssClass: 'panelform-body', //add a custom CSS class
          props: {
              booker
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
  watch: {
    refreshTable: function(){
      if (this.refreshTable == 'success'){
        this.fetchbooker();
        this.refreshTable = '';
      }
    }
  }
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
  color: white;
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
.panelform-body{
  background-color: #0bc443;
}
</style>
