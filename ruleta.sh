#!/bin/bash
#Colours
greenColour="\e[0;32m\033[1m"
endColour="\033[0m\e[0m"
redColour="\e[1;31m\033[1m"
blueColour="\e[0;34m\033[1m"
yellowColour="\e[0;33m\033[1m"
purpleColour="\e[0;35m\033[1m"
turquoiseColour="\e[0;36m\033[1m"
grayColour="\e[0;37m\033[1m"

function ctrl_c() {
    echo -e "\n\n ${redColour}[!] ${endColour}${greenColour}Saliendo...${endColour} \n"
    exit 1
    tput cnorm
}

#CTRL+c
trap ctrl_c INT

#sleep 10

#functions
function helpPanel() {
    echo -e "\n\n${redColour}[+]${endColour}${greenColour} Opciones ayuda: ${endColour}"
    echo -e "\t ${greenColour}-m)${endColour} ${grayColour}Monto de dinero con el que quiere jugar. "
    echo -e "\t ${greenColour}-t)${endColour} ${grayColour}Tecnica a emplear. ${endColour}"

    exit 1
}
#martingala
function martingala() {
    maxGanado=""
    counter=1
    echo -ne "${greenColour}¿Cuanto Dinero quieres apostar?${endColour} --> " && read bet
    echo -ne "${greenColour}A que deseas apostar siempre, "par" o "impar"? ${endColour}--> \n" && read par_impar
    back_up_bet="$(($bet))"
    tput civis #esto es para sacar el cursor

    echo -e "\n${greenColour}MONTO INICIAL: ${endColour}${yellowColour}$money${endColour}"
    while true; do
        money="$(($money - $bet))"
        randomNumber="$(($RANDOM % 37))" #CALCULAMOS EL RANDOM
        # echo -e "\n${greenColour}APUESTO: ${endColour}${yellowColour}$bet${endColour}${greenColour} ME QUEDAN: ${endColour}${yellowColour}$money${endColour}\n"
        if [ "$money" -gt 0 ]; then
            if [ "$par_impar" == "par" ]; then #check if the option is par(even)
                if [ "$(($randomNumber % 2))" -eq 0 ]; then
                    if [ $randomNumber -eq 0 ]; then

                        # echo -e "${redColour}[!] ${endColour}${blueColour}PERDIMOS!!${yellowColour} 0 ${endColour}\n"
                        # echo -e "\n${greenColour}MONTO ACTUAL: ${endColour}${yellowColour}$money${endColour}"
                        bet="$(($bet * 2))"
                    else
                        reward="$(($bet * 2))"      #Dinero ganado
                        money=$(($money + $reward)) #monto actualizado
                        #Guardando el maximo
                        if [[ $money -gt $maximoGanado ]]; then
                            maximoGanado=$money
                        fi

                        # echo -e "${redColour}[!] ${endColour}${greenColour}GANAS!!! El número es par : ${endColour}${yellowColour}$randomNumber${endColour}"
                        # echo -e "\n${greenColour}MONTO ACTUAL: ${endColour}${yellowColour}$money${endColour}"
                        bet="$(($back_up_bet))"
                    fi
                else

                    # echo -e "${redColour}[!] ${endColour}${redColour}PIERDES!!! El número es impar : ${endColour}${yellowColour}$randomNumber${endColour}"
                    # echo -e "\n${greenColour}MONTO ACTUAL: ${endColour}${yellowColour}$money${endColour}"
                    bet="$(($bet * 2))"

                fi
                # sleep 3
            elif [ "$par_impar" == "impar" ]; then
                if [ ! "$(($randomNumber % 2))" -eq 0 ]; then
                    if [ $randomNumber -eq 0 ]; then
                        # echo -e "${redColour}[!] ${endColour}${blueColour}PERDIMOS!!${yellowColour} 0 ${endColour}\n"
                        # echo -e "\n${greenColour}MONTO ACTUAL: ${endColour}${yellowColour}$money${endColour}"
                        bet="$(($bet * 2))"
                    else
                        reward="$(($bet * 2))"      #Dinero ganado
                        money=$(($money + $reward)) #monto actualizado
                        if [[ $money -gt $maximoGanado ]]; then
                            maximoGanado=$money
                        fi
                        # echo -e "${redColour}[!] ${endColour}${greenColour}GANAS!!! El número es impar : ${endColour}${yellowColour}$randomNumber${endColour}"
                        # echo -e "\n${greenColour}MONTO ACTUAL: ${endColour}${yellowColour}$money${endColour}"
                        bet="$(($back_up_bet))"
                    fi
                else

                    # echo -e "${redColour}[!] ${endColour}${redColour}PIERDES!!! El número es par: ${endColour}${yellowColour}$randomNumber${endColour}"
                    # echo -e "\n${greenColour}MONTO ACTUAL: ${endColour}${yellowColour}$money${endColour}"
                    bet="$(($bet * 2))"

                fi
                # sleep 3
            else #check if the option is impar(odd)
                echo -e "\n ${redColour}[!!!] ${endColour}${greenColour}Debes introducir las opciones correctas respetando las minusculas \"par\" o \"impar\"${endColour} \n"
                echo -e "\n\n ${redColour}[!] ${endColour}${greenColour}Apagando Programa...${endColour} \n"
                sleep 3
                tput cnorm
                exit 0
            fi
        else
            echo -e "\n ${redColour}[!!!] ${endColour}${greenColour}TE QUEDASTE SIN DINERO CULEAU!!...${endColour} \n"
            echo -e "${yellowColour}[+]${endColour}${grayColour} El valor máximo que alcanzaste fue de:${endColour} ${yellowColour}$maximoGanado${endoColour}\n"
            echo -e "${yellowColour}[+]${endColour}${grayColour} Cantidad de Jugadas:${endColour} ${yellowColour}$counter${endoColour}\n"
            
            tput cnorm
            exit 0
        fi
    counter="$(($counter+1))"
    done
    tput cnorm #Esto es para recuperar el cursor
}

#labouchere
function labouchere() {
    echo -e "\t El total de elementos es -->  ${#myNumbers[@]}"
    echo -e "\t ${greenColour}Great!)${endColour} ${grayColour}Juguemos con Labouchere ${endColour}"
    echo -e "\t ${greenColour}This is Labouchere option${endColour}"
    echo -ne "${greenColour}A que deseas apostar siempre, "par" o "impar"? ${endColour}--> \n" && read par_impar
    back_up_bet="$(($bet))" 
      
   
    while true; do	  
	  declare -a myNumbers=(1 2 3 4)
	  money="$(($money - $bet))"
		
	  if [ "$money" -gt 0 ]; then
		if [ "par_impar"=="par" ];then
			if [ "$(($randomNumber % 2))" -eq 0 ]; then
				if [ $randomNumber -eq 0 ]; then
				 	echo -e "\t ${redColour}[!] UPPS! Perdiste salio 0${endColour}"	
					unset myNumbers[0]
					unset myNumbers[-1]	
					
				fi	
			fi

		elif [ "par_impar"=="impar" ];then
		
		else
		  labouchere  	
		fi
	  fi

    done
}

while getopts "m:t:h" argumentos; do
    case $argumentos in
    m) money=$OPTARG ;;
    t) technique=$OPTARG ;;
    h) helpPanel ;;
    esac
done

if [ $money ] && [ $technique ]; then
    if [ "$technique" == "Martingala" ]; then
        martingala
    elif [ "$technique" == "ReverseLabouchere" ]; then
        labouchere
    else
        echo -e "\n ${redColour}Oh NO!${endColour} ${grayColour}Incorrect option: ${endColour} \n"
        echo -e "\n ${purpleColour}Check the options below: ${endColour}\n"
        echo -e "\t\u2022 ${greenColour}${endColour} ${grayColour}Martingala${endColour}"
        echo -e "\t\u2022 ${greenColour}${endColour} ${grayColour}ReverseLabouchere${endColour}"
        echo -e "\n\n ${redColour}[!] ${endColour}${greenColour}Wait 5 seconds...${endColour} \n"
        sleep 5
    fi
else
   helpPanel
fi
   
