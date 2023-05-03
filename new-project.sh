#!/usr/bin/env bash
# this script is done to facilitate the creation of a new project from a template, 
# it create the project and if provide do the first push for you

template_adress=${1}
project_name=${2}
repo_to_push=${3}
commit_message=${4}

help() {
    if [[ ${#} == 0 ]]; then
        echo "${0} <template_adress> <project_name> [repo_to_push] [commit_message]"
        exit
    fi
}

push_repository() {
    git init
    git add .
    if ! [[ -z ${commit_message} ]]; then
        git commit -m ":tada: ${commit_message}"    
    else
        git commit -m ":tada: begin project"
    fi
    git branch -M main
    git remote add origin $repo_to_push
    git push -u origin main
}

# exit the script if it cant clone
clone_repo_to_blank() {
    git clone ${template_adress} ${project_name}
    if [[ ${?} -eq 0 ]]; then
        cd ${project_name}
        rm -rf .git
        npm i
    else
        exit
    fi
}

main() {
    help
    clone_repo_to_blank
    code .
    if ! [[ -z ${repo_to_push} ]]; then
    push_repository
    fi
}

main



