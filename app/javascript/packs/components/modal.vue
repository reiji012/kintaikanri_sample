<template>
<div>
  <transition name="modal">
    <div class="modal-mask">
      <div class="modal-wrapper">
        <div class="modal-container">
          <button @click="$emit('close')" type="button" class="close">&times;</button>
          <div class="modal-header">
            <slot name="header">
            </slot>
          </div>

          <div class="modal-body">
            <slot name="body">
            </slot>
          </div>

          <div class="modal-footer">
            <slot name="footer">
          </slot>
          </div>
        </div>
      </div>
    </div>
  </transition>

</div>
</template>

