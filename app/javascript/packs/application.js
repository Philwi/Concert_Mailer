/* eslint no-console:0 */
// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.
//
// To reference this file, add <%= javascript_pack_tag 'application' %> to the appropriate
// layout file, like app/views/layouts/application.html.erb

console.log('Hello World from Webpacker')
import Vue from 'vue'
import $ from 'jquery'
import Kontakte from './Kontakte.vue'
import Nachrichten from './Nachrichten.vue'
import BootstrapVue from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.css'
import "vue-wysiwyg/dist/vueWysiwyg.css"
import 'bootstrap/dist/js/bootstrap.js'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'
import { VueSlideoutPanel } from 'vue2-slideout-panel';
import wysiwyg from "vue-wysiwyg";
import Resource from 'vue-resource';
Vue.use(Resource);
export const eventBus = new Vue();

Vue.use(wysiwyg, {});
Vue.component('slideout-panel', VueSlideoutPanel);
Vue.use(BootstrapVue);
Vue.component('font-awesome-icon', FontAwesomeIcon)

if (!('jQuery' in window)) {
  window.jQuery = $
  window.$ = $
}

$(window).on('load',function(){
  var kontakte = new Vue({
    el: '#kontakte',
    render: h => h(Kontakte)
  });
  var nachrichten = new Vue({
    el: '#nachrichten',
    render: h => h(Nachrichten)
  });

})
