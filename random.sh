	#!/bin/bash

a=$1

arr[0]="0"
arr[1]="1"
arr[2]="2"
arr[3]="3"
arr[4]="4"
arr[5]="5"
arr[6]="6"
arr[7]="7"
arr[8]="8"
arr[9]="9"
arr[10]="\"cadena0\""
arr[11]="\"cadena1\""
arr[12]="\"cadena2\""
arr[13]="\"cadena3\""
arr[14]="\"cadena4\""
arr[15]="\"cadena5\""
arr[16]="\"cadena6\""
arr[17]="\"cadena7\""
arr[18]="\"cadena8\""
arr[19]="\"cadena9\""
arr[20]="simbolo_cero"
arr[21]="simbolo_uno"
arr[22]="simbolo_dos"
arr[23]="simbolo_tres"
arr[24]="simbolo_cuatro"
arr[25]="simbolo_cinco"
arr[26]="simbolo_seis"
arr[27]="simbolo_siete"
arr[28]="simbolo_ocho"
arr[29]="simbolo_nueve"
arr[30]=salto
arr[31]=tabulador
arr[32]=" "
arr[33]=salto
arr[34]=salto


rand=$[$RANDOM % ${#arr[@]}]
last=${arr[$rand]}

while [ "$a" -ne 0 ]
do
    rand=$[$RANDOM % ${#arr[@]}]
    last=$last${arr[$rand]}
    ((a--))
done

echo $last > fuente.txt

sed -ie 's/salto/'$'/g' fuente.txt
sed -ie 's/tabulador/'\t'/g' fuente.txt

