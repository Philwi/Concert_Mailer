<template>
  <div id="booker">
    <div class="searchButtons">
      <div class="row">
        <div class="col-md-4">
          <form>
            <input type="text" v-model="searchCity" class="form-control" autofocus="true" placeholder="Stadt">
          </form>
        </div>
        <div class="col-md-4">
          <form>
            <input type="text" v-model="searchClub" class="form-control" autofocus="true" placeholder="Club">
          </form>
        </div>
        <div class="col-md-4">
          <form>
            <input type="text" v-model="searchBundesland" class="form-control" autofocus="true" placeholder="Bundesland">
          </form>
        </div>
      </div>
    </div>
    <br>
    <div class="bookerTable">
      <div class="row">
        <div class="col-md-12">
          <table class="table table-borderless">
            <thead>
              <tr>
                <th>Stadt</th>
                <th>Club</th>
                <th>E-Mail</th>
                <th>Bundesland</th>
                <th>Land</th>
                <th>
          <select v-model="pageRecordSize" class="form-control">
             <option value="5">5</option>
             <option value="10">10</option>
             <option value="20">20</option>
             <option value="50">50</option>
           </select>
         </th>
              </tr>
            </thead>
            <tbody>
              <tr v-for='(booker) in paginatedData'>
                <td> {{ booker.stadt }}</td>
                <td> {{ booker.club }}</td>
                <td> {{ booker.email }}</td>
                <td> {{ booker.bundesland }}</td>
                <td> {{ booker.land }}</td>
                <td>
                  <center>
                  <i class="fa fa-pencil fa-2x" style="margin-right: 10%"></i>
                  <i class="fa fa-trash fa-2x" @click="deletebooker(booker.id)"></i>
                </center>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
    <center>
      <i class="fa fa-chevron-circle-left fa-2x" @click="prevPage" style="margin-right: 15px"></i>
      <i class="fa fa-chevron-circle-right fa-2x" @click="nextPage"></i>
    </center>
  </div>
</template>
<script>
export default {
  name: 'booker',
  components: {
  },
  data() {
    return {
      searchCity: '',
      searchClub: '',
      searchBundesland: '',
      bookers: [],
      booker: '',
      pageNumber: 0,
      pageRecordSize: 10
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
    likebooker(booker) {
      let count = booker.like_count + 1
      this.$http.put('bookers/' + booker.id, {like_count: count})
        .then((res) => this.fetchbooker(), this.booker = '')
        .catch((error) => console.log('Got a problem' + error));
    },
    dislikebooker(booker) {
      if (booker.like_count > 0) {
        let count = booker.like_count - 1
        this.$http.put('bookers/' + booker.id, {like_count: count})
          .then((res) => this.fetchbooker(), this.booker = '')
          .catch((error) => console.log('Got a problem' + error));
      }
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
      this.pageNumber--;
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
</style><Paste>
