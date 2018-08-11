<template lang="pug">
#mailing

  b-tooltip(show='' target='mailingTable' placement="left")
    | An diese Kontakte wird eine E-Mail versendet

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
  #mailingTable.mailingTable
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
              th Kontaktperson
          tbody
            tr(v-for='(mailing) in paginatedData')
              td  {{ mailing.stadt }}
              td  {{ mailing.club }}
              td  {{ mailing.email }}
              td  {{ mailing.bundesland }}
              td  {{ mailing.land }}
              td  {{ mailing.name }}

    .row
      .col-md-4
      .col-md-4
        center
          i.fa.fa-chevron-circle-left.fa-2x(@click='prevPage' style='margin-right: 15px')
          b {{ pageNumber }}
          i.fa.fa-chevron-circle-right.fa-2x(@click='nextPage' style='margin-left: 15px')


</template>
<script>
import { eventBus} from './application'
export default {
  name: 'tableBookers',
  components: {
  },
  data() {
    return {
      searchCity: '',
      searchClub: '',
      searchBundesland: '',
      mailings: [],
      mailing: '',
      pageNumber: 0,
      pageRecordSize: 10,
    }
  },
  created() {
    this.fetchmailing();
  },
  watch: {
    filteredList: function(){
      eventBus.$emit('bookers', this.filteredList);
    }
  },
  methods: {
    fetchmailing() {
      fetch('mailings.json')
      .then((res) => { return res.json() })
      .then((res) => { this.mailings = res })
    },
    nextPage(){
      this.pageNumber++;
    },
    prevPage(){
      if (this.pageNumber > 0){
      this.pageNumber--;
      }
    }
  },
  computed: {
    filteredList(){
      return this.mailings.filter( mailing => {
        if ((this.searchCity == '') && (this.searchClub == '') && (this.searchBundesland == '')){
          return mailing}
        else if ((mailing.stadt !== null) && (this.searchClub == '')&& (this.searchBundesland == '')){
          return mailing.stadt.toLowerCase().includes(this.searchCity.toLowerCase())
        }
        else if ((mailing.bundesland !== null) && (this.searchClub == '')&& (this.searchCity == '')){
          return mailing.bundesland.toLowerCase().includes(this.searchBundesland.toLowerCase())
        }
        else if ((mailing.club !== null) && (this.searchCity == '')&& (this.searchBundesland == '')){
          return mailing.club.toLowerCase().includes(this.searchClub.toLowerCase())
        }
        else if ((mailing.club !== null) && (mailing.city !== null) && (this.searchCity != '') && (this.searchClub != '')&& (this.searchBundesland == '')){
          return mailing.club.toLowerCase().includes(this.searchClub.toLowerCase()) && mailing.stadt.toLowerCase().includes(this.searchCity.toLowerCase())
        }
        else if ((mailing.club !== null) && (mailing.bundesland !== null) && (this.searchBundesland != '') && (this.searchClub != '')&& (this.searchCity == '')){
          return mailing.club.toLowerCase().includes(this.searchClub.toLowerCase()) && mailing.bundesland.toLowerCase().includes(this.searchBundesland.toLowerCase())
        }
        else if ((mailing.bundesland !== null) && (mailing.city !== null) && (this.searchCity != '') && (this.searchBundesland != '') && (this.searchClub == '')){
          return mailing.bundesland.toLowerCase().includes(this.searchBundesland.toLowerCase()) && mailing.stadt.toLowerCase().includes(this.searchCity.toLowerCase())
        }
        else if ((mailing.bundesland !== null) && (mailing.city !== null) && (mailing.club !== null) && (this.searchCity != '') && (this.searchBundesland != '') && (this.searchClub != '')){
          return mailing.bundesland.toLowerCase().includes(this.searchBundesland.toLowerCase()) && mailing.stadt.toLowerCase().includes(this.searchCity.toLowerCase()) && mailing.club.toLowerCase().includes(this.searchClub.toLowerCase())
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
background-image: linear-gradient(to right, #f7973d, #e55a49, #be1e59, #810065, #2b0764);
}
thead{
}
tbody{

}

.mailingTable{
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
