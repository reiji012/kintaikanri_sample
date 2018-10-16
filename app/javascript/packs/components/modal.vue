<template>
<div>
  <transition name="modal">
    <div class="modal-mask">
      <div class="modal-wrapper">
        <div class="modal-container">

          <div class="modal-header">
            <slot name="header">
							田中　太郎さんですか？
            </slot>
          </div>

          <div class="modal-footer">
            <slot name="footer">
              帰社登録します
							<div>
              <button class="modal-default-button" @click="$emit('close')">
                はい
              </button>
							<button class="modal-default-button" @click="$emit('close')">
                いいえ
              </button>
							</div>
            </slot>
          </div>
        </div>
      </div>
    </div>
  </transition>

</div>
</template>