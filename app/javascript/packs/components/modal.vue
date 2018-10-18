<template>
<div>
  <transition name="modal">
    <div class="modal-mask">
      <div class="modal-wrapper">
        <div class="modal-container">

          <div class="modal-header">
            <slot name="header">
            </slot>
          </div>

          <div class="modal-footer">
            <slot name="footer" @click="$emit('close')">
              
            </slot>
          </div>
        </div>
      </div>
    </div>
  </transition>

</div>
</template>