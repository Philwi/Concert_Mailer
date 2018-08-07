<template>
  <div id="booker">
      <br><br>
      <center><h1>Veranstalter</h1></center>
      <br>
      <div class="row">
        <div class="col-md-12 col-md-offset-2">
          <form>
            <div class="col-md-6">
              <input type="text" v-model="booker" class="form-control" autofocus="true">
            </div>
            <div class="col-md-6">
              <button @click="addbooker()" class="btn btn-primary" :disabled="!booker.length">Add booker</button>
            </div>
					</form>
					<form>
						<input type="text" v-model="searchClub" class="form-control" autofocus="true" placeholder="Suche Club">
					</form>
				</div>
      </div>
      <br>
      <div class="row">
        <div class="col-md-12">
          <table class="table">
            <thead>
              <tr>
                <th>#</th>
                <th>Stadt</th>
                <th>Club</th>
                <th>E-Mail</th>
                <th>Bundesland</th>
                <th>Land</th>
                <th>Actions</th>
              </tr>
            </thead>
            <tbody>
              <tr v-for='(booker, index) in filteredList'>
                <td>{{ index + 1 }}</td>
                <td> {{ booker.stadt }}</td>
                <td> {{ booker.club }}</td>
                <td> {{ booker.email }}</td>
                <td> {{ booker.bundesland }}</td>
                <td> {{ booker.land }}</td>
                <td>
                  <button class="btn btn-danger btn-xs" @click="deletebooker(booker.id)">Delete</button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
</template>
<script>
export default {
  name: 'booker',
  components: {
  },
  data() {
    return {
      searchClub: '',
      bookers: [],
      booker: ''
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
  },
  computed: {
    filteredList(){
      return this.bookers.filter( booker => {
        if (booker.stadt !== null)
        return booker.stadt.toLowerCase().includes(this.searchClub.toLowerCase())
      })
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
}
</style><Paste>
