#!/bin/bash

#P27. Implementa la creación de usuarios de manera masiva. Se indicará una base
#de nombre de usuario usu y un número N. Se crearán los usuarios usu1, usuN...
#anotando en un fichero de log los usuarios que no se han podido crear en el
#caso de que ya existiesen.
clear
#Comprueba si el usuario es root.
if [ `whoami` != "root" ]
then
	echo "Usted no es usuario root."
	echo "Ejecute 'su' para identificarse y vuelva a ejecutar el script."
else
	#Comprueba la existencia del fichero log.
	if [ -e fallidos.log ]
	then
		rm fallidos.log	
	fi
	read -p "Introduzca el nombre base: " base
	read -p "Introduzca el número de usuarios a crear: " nummax
	numero='^[0-9]+$'
	#Comprueba que se haya introducido un número.
	if ! [[ $nummax =~ $numero ]]
	then
		echo "Debe de introducir un número de usuarios a crear."
	else
		#Repite el proceso el número de veces establecido.
		for i in $(seq 1 $nummax)
		do
		useradd $base$i >> /dev/null 2>&1
			if [ $? != "0" ]
			then	
				echo "Error al crear usuario" $base$i
				echo $base$i >> fallidos.log
			else
				echo "Creado el usuario" $base$i
			fi
		done
	fi
	#Comprueba si un fichero log ha sido creado.
	if [ -e fallidos.log ]
	then
		echo -e "\nAlgunos usuarios ya existían. Consulte el fichero log con:"
		echo "cat fallidos.log"
	fi
fi