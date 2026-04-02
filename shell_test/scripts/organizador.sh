#!/bin/bash

DIRECTORIES=( ./scr/ ./tb/ ./include/ ./scripts/ ./docs/ )

for directory in "${DIRECTORIES[@]}";
do
	if ! [ -d "$directory" ]; then
		echo "creating $directory"
		mkdir "$directory"
	else
		echo "Folder already $diretorio exists"
	fi
done

for file in ./*
do
	filename_with_ext=$(basename "$file")
	filename="${filename_with_ext%.*}"
	extension="${filename_with_ext##*.}"

	if [[ $extension == "v" ]]; then 
		if [[ $filename == *"_tb"* ]]; then
			if [ -f "tb/$filename_with_ext" ]; then
				echo "Not moving $filename_with_ext already exists"
			else
				echo "Moving to tb folder"
				mv $filename_with_ext "tb/"
			fi
		else
			if [ -f "scr/$filename_with_ext" ]; then
				echo "Not moving $filename_with_ext already exists"
			else
				echo "Moving to scr folder"
				mv $filename_with_ext "scr/"
			fi
		fi

	elif [[ $extension == "vh" ]]; then
		echo "Moving to include folder"
		if [ -f "include/$filename_with_ext" ]; then
			echo "Not moving $filename_with_ext already exists"
		else
			mv $filename_with_ext "include/"
		fi

	elif [[ $extension == "md" || $extension == "txt" ]]; then
		if [ ! -f ./docs/$filename_with_ext ]; then
			mv $file ./docs/
		else
			echo "Not moving $filename_with_ext already exists"
		fi
		
	elif [[ $extension == "tcl" || $extension == "do" || $extension == "sh" ]]; then
		if [ ! -f ./scripts/$filename_with_ext ]; then
			mv $file ./scripts/
		else
			echo "Not moving $filename_with_ext already exists"
		fi
	fi
done



