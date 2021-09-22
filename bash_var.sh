#!/bin/bash

clone_repository(){
    if [ $# -eq 1 ]
    then
        eval "git clone git@github.com:$1.git"
    elif [ $# -eq 2 ]
    then
        userName=$1
        repo=$2
        eval "git clone git@github.com:$userName/$repo.git"
    fi
}

pull_repository(){
    if [ $# -eq 0 ]
    then
        eval "git pull origin main"
    else
        branch=$1
        eval "git pull origin $branch"
    fi
}

push_repository(){
    if [ $# -eq 0 ]
    then 
        eval "git push origin main"
    else
        branch=$1
        eval "git push origin $branch"
    fi
}

git_push(){
    
    while getopts f:m:b flag
    do
        case "${flag}" in
            f) files=${OPTARG};;
            m) message=${OPTARG};;
            b) branch=${OPTARG};;
        esac
    done

    if [ ${#files} -eq 0 ]
    then
        files="."
    fi
    eval "git add $files"
    echo $message
    eval "git commit -m'$message'"
    push_repository $branch

}



alias gclone=clone_repository $@
alias gpush=git_push $@
alias gpull=pull_repository $@
