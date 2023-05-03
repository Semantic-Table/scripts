#!/usr/bin/env bash
# execute to open the list of site in morning-start.sh and open your project

if  [[ ${#} -eq 0 ]]; then
	echo "${0} <project_directory> <project_port>"
	exit
fi

project_directory=$1
project_port=$2
cat morning-start.txt | while read line ; do
	open ${line}
done

if ! [[ -z ${project_directory} ]]; then
	cd $HOME/Sites/${project_directory}
	if [[ $? -eq 0 ]]; then
		result=$(grep "start" package.json)
		if ! [[ -z result ]]; then
			npm start &
			code .
			sleep 3
			open "http://localhost:${project_port}"
		fi
	fi
fi
