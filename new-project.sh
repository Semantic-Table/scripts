#!/usr/bin/env bash

# -----------------------------------------------------------------
# this script is done to facilitate the creation of a new project from a template, 
# it create the project and if provide do the first push for you
# -----------------------------------------------------------------

function HELP() {
    echo ""
    echo "projectfromteplate template_adress project_name [repo_to_push] [commit_message]"
    echo ""
}

template_adress=$1
project_name=$2
repo_to_push=$3
commit_message=$4

if [[ $# == 1 && $1 == "help" ]]; then
    HELP
    exit
fi

git clone $template_adress $project_name
cd $project_name
rm -rf .git
npm i

if [[ $? -eq 0 ]]; then 
    code .
    if ! [[ -z $repo_to_push ]]; then
        git init
        git add .

        if ! [[ -z $commit_message ]]; then
            git commit -m ":tada: $commit_message"    
        else
            git commit -m ":tada: begin project"
        fi
        
        git branch -M main
        git remote add origin $repo_to_push
        git push -u origin main
    fi
fi

