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
    echo -e "\t \n ${greenColour}Dinero Actual: ${endColour}${redColour}${money} ${endColour}${greenColour}Euros ${endColour} \n"
    echo -ne "${greenColour}¿Cuanto Dinero quieres apostar?${endColour} --> " && read initial_bet
    echo -ne "${greenColour}A que deseas apostar siempre, PAR o IMPAR? ${endColour}--> " && read par_impar
    echo -e "${greenColour}Vamos a jugar con una cantidad de${endColour} ${redColour}$initial_bet${endColour}${greenColour} Euros a los números que son ${endColour}${redColour}$par_impar${endColour}. \n"
}

#labouchere
function labouchere() {
    echo -e "\t ${greenColour}Great!)${endColour} ${grayColour}Juguemos con Labouchere ${endColour}"
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
