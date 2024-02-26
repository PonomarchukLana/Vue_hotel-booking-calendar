import Vue from 'vue'
import Vuex from 'vuex'
import data from '../server/bookings.json'

Vue.use(Vuex);

export const store = new Vuex.Store({
  state: {
    data: []
  },
  getters: {},
  mutations: {
    setJsonData(state, data) {
      state.data = data;
    },
  },
  actions: {
    async fetchJsonData({ commit }) {
      try {
        commit('setJsonData', data);
      } catch (error) {
        console.error('Error fetching JSON data:', error);
      }
    },
  },
});
