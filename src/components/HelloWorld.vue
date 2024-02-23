<template>
  <div>
    <button type="button" @click="changeWeek()">
      prev week
    </button>

    <button type="button" @click="changeWeek(1)">
      next week
    </button>

    <button type="button" @click="currentWeek">
      today
    </button>
    <table class="table table-bordered">
      <thead>
        <tr>
          <th></th>
          <th v-for="day in week" :key="day">{{ day }}</th>
        </tr>
      </thead>

      <tbody>
        <tr v-for="apartment in ['Premier Suite', 'Superior Room', 'Grand Executive', 'Suite Luxury']" :key="apartment">
          <td class="apartment">{{ apartment }}</td>
          <td v-for="day in week" :key="day">
            <span v-if="apartment === reservApp
              && new Date(day).getTime() >= start && new Date(day).getTime() <= end" class="reserved" v-bind:class="{
    start: new Date(day).getTime() === start,
    during: new Date(day).getTime() > start && new Date(day).getTime() < end,
    end: new Date(day).getTime() === end,
  }">
              <!--<span v-if="apartment === reservApp
                && (end - start) <= new Date(day).getTime()">-->
              <!--</span>-->
            </span>
          </td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
export default {
  name: 'HelloWorld',
  data: function () {
    return ({
      start: new Date('2024-02-20').getTime(),
      end: new Date('2024-02-24').getTime(),
      reservApp: 'Suite Luxury',
      week: [],
      weekCount: 0,
    })
  },

  mounted() {
    this.week = this.selectWeek(new Date());
  },

  methods: {
    formattedDate(strData) {
      const year = strData.getFullYear();
      const month = String(strData.getMonth() + 1).padStart(2, '0');
      const day = String(strData.getDate()).padStart(2, '0');

      return `${year}-${month}-${day}`;
    },

    selectWeek(date, weekOffset = 0) {
      console.log(weekOffset)
      const startDate = new Date(date);
      startDate.setDate(startDate.getDate() + weekOffset);
      console.log(startDate)
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

<!--<script>
export default {
  name: 'HelloWorld',
  props: {
    msg: String
  }
}
</script>-->

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
table {
  border: 1px solid #eff5ff;
  border-collapse: collapse;
}

table th,
td {
  border: 2px solid #eff5ff;
  padding: 10px 20px;
}

.apartment {
  padding: 20px 30px;
}

td .reserved {
  cursor: pointer;
}

td {
  position: relative;
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
  z-index: 999;
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
  z-index: 999;
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
  z-index: 999;
}
</style>
