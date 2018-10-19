<template>
    <div>
        <div class="switchButton" style="display: flex; float: left;">
            <div class="box" style="border-radius: 20px;">
                <router-link to="/">帰社登録</router-link>
            </div>
            <div class="box" style="border-radius: 20px;">
                <router-link to="recordCheck">記録確認</router-link>
            </div>
        </div>
        <div id="userPut" class="box" style="border-radius: 20px; float: right;">
            <router-link to="userRegistration">ユーザー登録</router-link>
        </div>
    </div>
</template>

<style lang="sass">
</style>
