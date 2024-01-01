#!/bin/bash 
declare -a myArray=(1 5 3 5 4 7) 

echo "${myArray[@]}"

unset myArray[0]
unset myArray[-1]

echo "Esto es lo que quedo del array --> ${myArray[@]}"

echo -e "\t Primero tenemos que igualar el array porque guarda la posicion del mismo. "
myArray=(${myArray[@]})  #Es importante LIMPIAR el array para que olvide las posiciones. 

echo "${myArray[0]}"











