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

	filename="${filename_with_ext%.*}"
	extension="${filename_with_ext##*.}"

	echo "============"
	echo "Path: $filepath"
	echo "Filename with extension: $filename_with_ext"
	echo "Filename without extension: $filename"
	echo "File extension: $extension"

	if [ $extension == ".md" ]; then
		if [ ! -f $filename_with_ext ]; then
			mv $filepath ./docs/
		else
			echo "Arquivo $filename_with_ext Existe no diretório docs"
		fi
	fi 
done



