#!/bin/bash

#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[0;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

#Variables Globales
mainlink="https://htbmachines.github.io/bundle.js"

# Ctrl+C
function ctrl_c(){
  echo -e "\n ${redColour} [!] Saliendo.... ${endColour}" 
  exit 1
}
function Helppanel(){
  echo -e "\n ${yellowColour}[+]${endColour}${purpleColour} USO:${endColour}"
  echo -e "\n ${greenColour}\t[+]-n\t${endColour} ${purpleColour}<Nombre de la máquina>: Buscaremos una máquina por el nombre${endColour}"
  echo -e "\n${greenColour}\t[+]-u\t${endColour} ${purpleColour}Actualizara el archivo local con los datos mas recientes de la web${endColour}"
  echo -e "\n${greenColour}\t[+]-i\t${endColour} ${purpleColour}<IP>: Buscara el nombre de la maquina basandose en la IP${endColour}"
  echo -e "\n${greenColour}\t[+]-d\t${endColour} ${purpleColour}<Dificultad>: Buscara por el nivel de dificultad de la maquina${endColour}"
  echo -e "\n${greenColour}\t[+]-o\t${endColour} ${purpleColour}<Sistema operativo>: Buscara el nombre de la maquina basandose en el sistema operativo${endColour}"
  echo -e "\n${greenColour}\t[+]-s\t${endColour} ${purpleColour}<Skill>: Buscara el nombre de la maquina basandose en la skill${endColour}"
  echo -e "\n ${greenColour}\t[+]-y\t${endColour} ${purpleColour}<Nombre e la máquina>: Mostrar el enlace de la resolucion de la maquina${endColour}"
  echo -e "\n ${greenColour}\t[+]-h\t${endColour} ${purpleColour}Mostrara el panel de ayuda${endColour}"

}

function colors_dificulty(){
    dificultad="$1"
    case $dificultad in
        "Fácil")
          difColor=${greenColour}
            ;;
        "Media")
          difColor=${yellowColour}
            ;;
        "Difícil")
          difColor=${redColour}
            ;;
        "Insane")
            difColor=${purpleColour}
            ;;
    esac
}

function colorOS(){
  case $os in
    "Windows")
      colorOS=${blueColour}
      ;;
    "Linux")
      colorOS=${yellowColour}
      ;;
  esac

}


function searchMachine(){
machineName="$1"
searchMachine_cheker=$(cat bundle.js | awk "/name: \"$machineName\"/,/resuelta:/" | sed 's/^ *//'| tr -d '",'':' | grep -vE "id|sku|resuelta")
  if [ "$searchMachine_cheker" ]; then
    cat bundle.js | awk "/name: \"$machineName\"/,/resuelta:/" | sed 's/^ *//'| tr -d '",'':' | grep -vE "id|sku|resuelta"|
    while read -r line; do
      text=$(echo "$line" | awk '{print $NF}')
      title=$(echo "$line" | awk '{print $1}')
      if [[ "$title" == "dificultad" ]]; then
        text=$(colors_dificulty "$text")
      fi
      echo -e "${yellowColour}[*]${endColour}${purpleColour} $title${endColour}${turquoiseColour} --> $text${endColour}"
      done
  else 
  echo -e "\n${yellowColour}[!]${endColour} ${redColour}La maquina introducida no existe${endColour}${yellowColour} [!]${endColour}"
  fi
}

function updateFiles(){
  tput civis
  if [ ! -f bundle.js ]; then
    echo -e "\n${yellowColour}[+]${endColour} ${purpleColour} Descargando archivos necesarios...${endColour}"
    curl -s $mainlink > bundle.js
    js-beautify bundle.js | sponge bundle.js
    echo -e "\n${yellowColour}[+]${endColour}${purpleColour}Todos los archivos han sido descargados correctamente...${endColour}"

  else
    echo -e "\n${yellowColour}[+]${endColour}${purpleColour}Comprovando si hay actualizaciones...${endColour}"
    curl -s $mainlink > bundle_temp.js
    js-beautify bundle_temp.js | sponge bundle_temp.js
    md5_temp_file=$(md5sum bundle_temp.js | awk {'print $1'})
    md5_original_file=$(md5sum bundle.js | awk {'print $1'})

    if [ "$md5_original_file" == "$md5_temp_file" ]; then

      echo -e "\n${yellowColour}[+]${endColour} ${purpleColour}El archivo existe y esta actualizado...${endColour}"

    else
      echo -e "\n${yellowColour}[+]${endColour}${purpleColour}El archivo no esta actualizado, actulaizando...${endColour}"
      sleep 1
      rm bundle.js && mv bundle_temp.js bundle.js

      echo -e "\n${yellowColour}[+]${endColour}${purpleColour}Todos los archivos han sido actualizados correctamente.${endColour}"
      

    fi
  fi
tput cnorm
}   
function searchIP(){
ipAddress="$1"
IP_checker=$(cat bundle.js | grep "ip: \"$ipAddress\"" -B 3 | grep "name: " | awk 'NF{print $NF}' | tr -d '"'',')  
if [ "$IP_checker" ]; then
echo -e "\n${yellowColour}[+]${endColour}${purpleColour} La máquina es${endColour}${turquoisColour}$machineName:${endColour}"

  cat bundle.js | grep "ip: \"$ipAddress\"" -B 3 | grep "name: " | awk 'NF{print $NF}' | tr -d '"'',' | while read -r line; do 
  echo -e "\n${blueColour}$line${endColour}"
  done
  else 
  echo -e "${yellowColour}[!]${endColour} ${redColour} La IP introducida es incorrecta ${endColour}${yellowColour} [!]${endColour}"

  fi
}

function youtubeTutos(){
  machineName="$1"
linkChecker="$(cat bundle.js | awk "/name: \"$machineName\"/,/resuelta:/" | sed 's/^ *//' | tr -d ',' | tr -d '"' | grep youtube)"
if [ "$linkChecker" ]; then
  echo -e "\n${yellowColour}[+]${endColour} ${purpleColour}La resolucion de la maquina ${greyColour}$machineName${endColour}${purpleColour} es :${endColour}"
  echo -e "\n${blueColour}$linkChecker${endColour}"
else
  echo -e "${yellowColor}[!]${endColour}${redColour} El nombre de la maquina es incorrecto ${endColour}${yellowColour}[!]${endColour}"
fi

}

function searchDifficulty(){
difficulty="$1"
colors_dificulty "$difficulty"
checker_dificulty="$(cat bundle.js | grep "dificultad: \"$difficulty\"" -B 5 | grep name | awk 'NF{print $NF}' | tr -d '"'',' | column)"
if [ "$checker_dificulty" ]; then
  echo -e "\n${yellowColour}[+]${endColour}${purpleColour} Mostrando todas las maquinas de dificultad ${difColor}$difficulty${endColour}${purpleColour}:\n${endColour}"
  echo -e "${difColor}$checker_dificulty${endColour}"
  else 
  echo -e "\n${yellowColour}[!]${endColour}${redColour} La dificultad introducida no existe ${endColour}${yellowColour}[!]${endColour}"
fi
}


function searchOS(){
  os="$1"
  os_checker="$(cat bundle.js | grep "so: \"$os\"" -C5 | grep "name: " | awk 'NF{print $NF}' | tr -d '"'',' | column)"
  colorOS "$os"  
  if [ "$os_checker" ]; then
    echo -e "\n${colorOS}$os_checker${endColour}"
    else
      echo -e "${yellowColour}[!]${endColour}${redColour} El sistema operativo que estas intentando buscar no existe ${endColour}${yellowColour}[!]${endColour}"
  fi

}

function difficultyandOS(){
  os="$1"
  difficulty="$2"
  colors_dificulty "$difficulty"
  colorOS "$os"
  checker_os_difficulty="$(cat bundle.js | grep "so: \"$os\"" -C5 | grep "dificultad: \"$difficulty\"" -C5 | grep "name: " | awk 'NF{print $NF}' | tr -d '"'',' | column)"
  if [ "$checker_os_difficulty" ]; then
    echo -e "${yellowColour}[+]${endColour}${purpleColour} Mostrando todas las maquinas${endColour} ${colorOS}$os${endColour}${purpleColour} de dificultad${endColour} ${difColor}$difficulty${endColour}${purpleColour}:${endColour}\n"
    echo -e "${greyColour}$checker_os_difficulty${endColour}"
  else
    echo -e "${yellowColour}[!]${endColour}${redColour} La dificultad o el sistema operativo no existen ${endColour}${yellowColour}[!]${endColour}"
  fi
}


function getSkill(){
skill="$1"
skillchecker="$(cat bundle.js | grep "skills: " -B 6| grep "$skill" -i -B 6| grep "name: " | awk 'NF{print $NF}' | tr -d '"'',' | column)"

if [ "$skillchecker" ]; then
  echo -e "\n${yellowColour}[+]${endColour}${purpleColour} Mostrando todas las maquinas que apliquen la skill ${redColour}$skill${endColour}${purpleColour}:${endColour}"
  echo -e "${blueColour}$skillchecker${endColour}"

else
echo -e "${yellowColour}\n[!]${endColour}${redColour} La skill que estas buscando no existe ${endColour}${yellowColour}[!]${endColour}"
fi



}
#Indicadores
declare -i parameter=0
trap ctrl_c INT
declare -i parameter_os=0
declare -i parameter_difficulty=0

#GetOpts
while getopts "n:ui:y:d:o:s:h" arg; do
  case $arg in
    n) machineName="$OPTARG"; let parameter+=1;;
    u) let parameter+=2;;
    i) ipAddress="$OPTARG"; let parameter+=3;;
    y) machineName="$OPTARG"; let parameter+=4;;
    d) difficulty="$OPTARG";let parameter_difficulty+=1; let parameter+=5;;
    o) os="$OPTARG"; let parameter_os+=1; let parameter+=6;;
    s) skill="$OPTARG"; let parameter+=7;;
    h) Helppanel;;
  esac

done

if [ $parameter -eq 1 ]; then
  searchMachine "$machineName"
  elif [ $parameter -eq 2 ]; then
    updateFiles
  elif [ $parameter -eq 3 ]; then
    searchIP "$ipAddress"
  elif [ $parameter -eq 4 ]; then 
    youtubeTutos "$machineName" 
  elif [ $parameter -eq 5 ]; then 
    searchDifficulty "$difficulty"
  elif [ $parameter -eq 6 ]; then
    searchOS "$os"
  elif [ $parameter_difficulty -eq 1 ] && [ $parameter_os -eq 1 ]; then
    difficultyandOS "$os" "$difficulty"
  elif [ $parameter -eq 7 ]; then
    getSkill "$skill"
  else
    Helppanel
fi
