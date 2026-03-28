#!/bin/bash

diretorios=("src" "tb" "include" "scripts" "docs")

for diretorio in  "${diretorios[@]}"; do

	if [ ! -d $diretorio ]; then
		mkdir $diretorio
		echo "Pasta criada: " $diretorio
	else
		echo "Pasta  $diretorio já existe"
	fi
done



for file in ./*
do
	filepath=$file
	filename_with_ext=$(basename "$filepath")
	filename="${filename_with_ext%.*}"
	extension="${filename_with_ext##*.}"


	if [[ $extension == "md" || $extension == "txt" ]]; then
		if [ ! -f ./docs/$filename_with_ext ]; then
			mv $file ./docs/
		else
			echo "Arquivo $filename_with_ext Existe no diretório docs"
		fi
	fi 

	if	[[ $extension == "tcl" || $extension == "do" || $extension == "sh" ]]; then
		if [ ! -f ./scripts/$filename_with_ext ]; then
			mv $file ./scripts/
		else
			echo "Arquivo $filename_with_ext Existe no diretório scripts"
		fi
	fi

	if [ $extension = "vh" ]; then
		if [ ! -f ./include/$filename_with_ext ]; then
			mv $file ./include/
		else
			echo "Arquvio $filename_with_ext Existe no diretório include"
		fi
	fi

	if [[$extension == "v" ]]; then
		if [[$filename == *"_tb"*]]; then
			if [ ! -f ./tb/$filename_with_ext ]; then
				mv $file ./tb
			else 
				echo "Arquvio $filename_with_ext Existe no diretório tb"
			fi
		else
			if [ ! -f ./src/$filename_with_ext ]; then
				mv $file ./src
			else
				echo "Arquvio $filename_with_ext Existe no diretório src"
			fi
		fi
	fi
done



