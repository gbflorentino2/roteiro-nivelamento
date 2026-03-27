#!/bin/bash



DIRECTORIES=( ./scr/ ./tb/ ./include/ ./scripts/ ./docs/ )

for directory in "${DIRECTORIES[@]}";
do
	if ! [ -d "$directory" ]; then
		echo "creating $directory"
		mkdir "$directory"
		#rmdir "$directory"
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
				echo "Not moving already exists"
			else
				echo "Moving to tb folder"
				mv $filename_with_ext "tb/"
			fi
		else
			if [ -f "scr/$filename_with_ext" ]; then
				echo "Not moving already exists"
			else
				echo "Moving to scr folder"
				mv $filename_with_ext "scr/"
			fi
		fi

	elif [[ $extension == "tcl" ]]; then
		echo "Moving to scripts folder"
		if [ -f "scripts/$filename_with_ext" ]; then
			echo "Not moving already exists"
		else
			mv $filename_with_ext "scripts/"
		fi

	elif [[ $extension == "do" ]]; then
		echo "Moving to scripts folder"
		if [ -f "scripts/$filename_with_ext" ]; then
			echo "Not moving already exists"
		else
			mv $filename_with_ext "scripts/"
		fi

	elif [[ $extension == "vh" ]]; then
		echo "Moving to include folder"
		if [ -f "include/$filename_with_ext" ]; then
			echo "Not moving already exists"
		else
			mv $filename_with_ext "include/"
		fi

	elif [[ $extension == "md" ]]; then
		echo "Moving to docs folder"
		if [ -f "docs/$filename_with_ext" ]; then
			echo "Not moving already exists"
		else
			mv $filename_with_ext "docs/"
		fi
	fi
done
