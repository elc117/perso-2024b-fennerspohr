<script setup>
import { ref} from 'vue'
import axios from 'axios'

const getURL = "http://localhost:3000/"
const started = ref(false)
const isLoading = ref(false)
const lyrics = ref()
const currentLyric = ref()

async function getLyrics(){
  isLoading.value = true
  started.value = true
  axios.get(getURL + "listlyrics")
      .then(response=>{
        console.log(response)
        isLoading.value = false
        lyrics.value = response.data
        currentLyric.value = lyrics.value[0]
      })
}
</script>

<template>
<!--<header>-->
  <div>
    <div class="flex justify-center">
      <img class="h-56" src="./assets/title.png" alt="título da página">
    </div>

    <div class="flex justify-center">
<!--      <h4 class="text-center">Adivinhe a música da cantora Chappell Roan pela letra!</h4>-->
    </div>

    <div>
      <div class="flex justify-center mt-4" v-if="!started">
        <button class="bg-[#C1EEFF] hover:bg-[#99E4FF] text-[#2A1F2D] font-bold py-2 px-4 rounded" @click="getLyrics">
          Jogar</button>
      </div>

      <div v-if="isLoading" class="mt-4">
        <h4 class="text-center">Carregando...</h4>
      </div>

      <div v-if="lyrics">
        {{currentLyric}}
      </div>
    </div>
  </div>
  <div></div>
<!--</header>-->

</template>

