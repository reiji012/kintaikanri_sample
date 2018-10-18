<template>
<div>
  <transition name="modal">
    <div class="modal-mask">
      <div class="modal-wrapper">
        <div class="modal-container">

          <div class="modal-header">
            <slot name="header">
				header
            </slot>
          </div>

          <div class="modal-footer">
            <slot name="footer">
              <div @click="$emit('close')" class="box">確認</div>
            </slot>
          </div>
        </div>
      </div>
    </div>
  </transition>

</div>
</template>