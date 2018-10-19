<template>
    <div>
        <div class="switchButton" style="display: flex; float: left;">
            <router-link to="/">
            <div class="box" style="border-radius: 20px;">
                帰社登録
            </div>
            </router-link>
            <router-link to="recordCheck">
            <div class="box" style="border-radius: 20px;">
                記録確認
            </div>
            </router-link>
        </div>
        <router-link to="userRegistration">
        <div id="userPut" class="box" style="border-radius: 20px; float: right;">
            ユーザー登録
        </div>
        </router-link>
    </div>
</template>

<style lang="sass">
</style>
