<template>
  <div>
    <switchButton></switchButton>
    <div id="show-modal" @click="showModal = true" class="box userBox">
        田中 太郎
    </div>
    <div class="box userBox">
        上田 花子
    </div>
    <div class="box userBox">
        斎藤 和宏
    </div>
    <div class="box userBox">
        松田 浩二
    </div>
  <!-- use the modal component, pass in the prop -->
  <modal v-if="showModal" @close="showModal = false">
    <!--
      you can use custom content here to overwrite
      default content
    -->
    <h3 slot="header">田中　太郎さんですか？</h3>
  </modal>
</div>
  
</template>

<script>
import Switch from "./button.vue";
import Modal from "./modal.vue";
export default {
  data: function() {
    return {
      showModal: false
    };
  },
  components: {
    switchButton: Switch,
    modal: Modal
  }
};
</script>
<style lang="sass">
    
</style>

