<template>
  <div>
    <div class="buttons">
      <button type="button" @click="changeWeek()">
        <font-awesome-icon icon="angle-left" />
      </button>

      <button type="button" @click="changeWeek(1)">
        <font-awesome-icon icon="angle-right" />
      </button>

      <button type="button" @click="currentWeek">
        Today
      </button>
    </div>

    <div class="table table-bordered">
      <div>
        <div class="row">
          <div class="cells"></div>
          <div v-for="day in week" :key="day" class="cells">
            {{ day }}
          </div>
        </div>
      </div>

      <div>
        <div
          v-for="room in rooms"
          :key="room"
          class="row"
        >
          <div class="apartment cells">{{ room }}</div>
          <div class="cells" v-for="day in week" :key="day">
            <FragmentItem v-for="item in data" :key="item.id">
              <span
                @click="testClick"
                v-if="room === item.roomDetails.name
                && new Date(day).getTime() >= new Date(item.start).getTime() && new Date(day).getTime() <= new Date(item.end).getTime()"
                class="reserved"
                v-bind:class="{
                  start: new Date(day).getTime() === new Date(item.start).getTime(),
                  during: new Date(day).getTime() > new Date(item.start).getTime() && new Date(day).getTime() < new Date(item.end).getTime(),
                  end: new Date(day).getTime() === new Date(item.end).getTime()}"
                >
                <span
                  style="position: absolute; white-space: nowrap; transform: translate(15%, 15%); z-index: 999;"
                  v-if="room === item.roomDetails.name && new Date(item.start).getTime() === new Date(day).getTime()"
                >
                  {{ item.name }}
                </span>
              </span>
            </FragmentItem>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import FragmentItem from './FragmentItem.vue';

export default {
  name: 'ReserveCalendar',
  data: function () {
    return ({
      week: [],
      weekCount: 0,
    })
  },
  components: {
    FragmentItem
  },

  computed: {
    rooms() {
      return [...new Set(this.data.map(item => item.roomDetails.name))];
    },

    data() {
      return this.$store.state.data;
    },
  },

  mounted() {
    this.week = this.selectWeek(new Date());
    this.$store.dispatch('fetchJsonData');
  },

  methods: {
    testClick() {
      console.log('work')
    },

    formattedDate(strData) {
      const year = strData.getFullYear();
      const month = String(strData.getMonth() + 1).padStart(2, '0');
      const day = String(strData.getDate()).padStart(2, '0');

      return `${year}-${month}-${day}`;
    },

    selectWeek(date, weekOffset = 0) {
      const startDate = new Date(date);
      startDate.setDate(startDate.getDate() + weekOffset);

      const dates = Array(7).fill(startDate).map((el, i) =>
        new Date(el.setDate((el.getDate() - el.getDay() + i + 1))));

      return dates.map(data => this.formattedDate(data));
    },

    currentWeek() {
      this.week = this.selectWeek(new Date());
    },

    changeWeek(next = 0) {
      if (next) {
        this.weekCount += 7;
      } else {
        this.weekCount -= 7;
      }
      this.week = this.selectWeek(new Date(), this.weekCount);
    },
  },
};
</script>

<style scoped>
.buttons {
  display: flex;
  gap: 10px;
  margin-bottom: 20px;
}

.table {
  overflow: hidden;
}
.row {
  display: grid;
  grid-template-columns: 2fr repeat(7, 1fr);
  border-top: 1px solid #d2d2d2;
  border-left: 1px solid #d2d2d2;
}

.row .cells {
  position: relative;
  padding: 15px;
  text-align: center;
  border-bottom: 1px solid #d2d2d2;
  border-right: 1px solid #d2d2d2;
  font-size: 14px;
  white-space: nowrap;
}

.apartment {
  padding: 20px 30px;
}

.reserved {
  cursor: pointer;
}

.end::before {
  content: " ";
  background: #5191FA;
  border-radius: 0 25px 25px 0;
  width: 45%;
  height: 40px;
  display: block;
  position: absolute;
  bottom: 0;
  left: -2px;
  z-index: 998;
}

.start::after {
  content: " ";
  background: #5191FA;
  border-radius: 25px 0 0 25px;
  width: 45%;
  height: 40px;
  display: block;
  position: absolute;
  bottom: 0;
  right: -2px;
  z-index: 998;
}

.during::before {
  content: " ";
  background: #5191FA;
  width: 100%;
  height: 40px;
  display: block;
  position: absolute;
  bottom: 0;
  left: 0;
  padding: 0 2px;
  z-index: 998;
}

.reserved:nth-child(2).end::before,
.reserved:nth-child(2).start::after,
.reserved:nth-child(2).during::before {
  background: #f7fa51;
  height: 20px;
}
</style>
