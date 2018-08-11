<template lang="pug">
  p
    | Hallo
</template>

<script>
export default {
  name: 'panelform',
  props: {
    data: {
    }
  },
  data() {
    return {};
  },
  methods: {
    closePanel() {
      this.$emit('closePanel', {
        name: this.form.name
      });
    }
  }
};
</script>
