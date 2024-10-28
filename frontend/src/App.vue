<script setup>
import { ref} from 'vue'
import axios from 'axios'

const getURL = "http://localhost:3000/"
const started = ref(false)
const ended = ref(false)
const isLoading = ref(false)
const lyrics = ref({})
const currentLyric = ref()
const currentAnswer = ref()
let i = 0;

async function getLyrics(){
  isLoading.value = true
  started.value = true
  ended.value = false
  await axios.get(getURL + "listlyrics")
      .then(response=>{
        isLoading.value = false
        lyrics.value = response.data
        currentLyric.value = lyrics.value[0];
      })
}

async function getAnswer(){
  await axios.get(getURL + "/answer/" + currentAnswer.value + "/" + currentLyric.value.idLyric)
      .then(response=>{
        if(response.data === true){
          document.getElementById("resposta").value = ''
          if(i < lyrics.value.length - 1){
            i++;
            currentLyric.value = lyrics.value[i]
          }
          else{
            ended.value = true
          }
        }
      })
}
</script>

<template>
<!--<header>-->
  <div>
    <div class="flex justify-center">
      <img class="h-58" src="./assets/title.png" alt="título da página">
    </div>
  <div class="flex justify-center mb-20">
    <button onclick="help.showModal()">
      <img src="./assets/help.svg" class="h-8" alt="help">
    </button>
  </div>
    <dialog id="help" class="modal">
      <div class="modal-box bg-[#2A1F2D]">
        <form method="dialog">
          <button class="btn btn-sm btn-circle btn-ghost absolute right-2 top-2">✕</button>
        </form>
        <h3 class="text-lg font-bold">Como funciona?</h3>
        <p class="py-4 text-[#C1EEFF]">Clave é um jogo de adivinhar músicas a partir da letra! Essa é a "Pink Pony Club Edition",
        que conta com diversas músicas da cantora Chappell Roan.</p>
        <p class="text-[#C1EEFF]"> Para jogar, basta clicar em "Jogar", e você verá o verso de uma música. Digite sua resposta e envie para ir
        para a próxima música!</p>
        <p>Obs.: o jogo não diferencia letras maiúsculas, mas acentos e símbolos sim!</p>
      </div>
    </dialog>
    <div class="h-max flex justify-center">
      <div class="mt-4" v-if="!started">
        <button class="bg-[#C1EEFF] hover:bg-[#99E4FF] text-[#2A1F2D] font-bold py-2 px-4 rounded" @click="getLyrics">
          Jogar</button>
      </div>

      <div v-if="isLoading" class="mt-4 ">
        <h4 class="text-center">Carregando...</h4>
      </div>

      <div  v-if="lyrics.length > 0" >
        <div v-if="ended" >
          <h1 class="text-3xl text-[#C1EEFF] text-center"> Parabéns!</h1>
          <p class="text-xl mt-2">Você respondeu todas as músicas corretamente! Deseja jogar novamente?</p>
          <div class="flex justify-center mt-6">
            <button class="bg-[#C1EEFF] hover:bg-[#99E4FF] text-[#2A1F2D] font-bold py-2 px-4 rounded" @click="getLyrics">
              Jogar</button>
          </div>

        </div>
        <div v-else>
          <h1 class="text-2xl text-[#C1EEFF] text-center">{{currentLyric.verse}}</h1>
          <p class="text-center pt-3">Qual o nome da música?</p>
          <div class="join mt-6 flex justify-center">
            <input id="resposta" class="input input-bordered join-item" placeholder="Digite a resposta" @change="currentAnswer = $event.target.value"/>
            <button class="btn join-item bg-[#C1EEFF] " @click="getAnswer">
              <img src="./assets/send.svg" alt="Enviar" class="h-6">
            </button>
          </div>
        </div>


      </div>
    </div>
  </div>
  <div></div>
<!--</header>-->

</template>

