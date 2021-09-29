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

activate_global_env(){
	env=$1
	eval "source ~/envs/$env/bin/activate"
}


show_personal_help(){
	echo "gclone : Clone repository acception in username/repo format or 'username repo' format"
	echo "gpush : Add files commit and push data. -f flag for files, -m for message and -b for desired branch"
        echo "gpull : Pull desired branch from the repository, accepts branch name as argument"
	echo "enact : Activates global enviroment, accepts environment name stored in envs folder"	
}



alias assist=show_personal_help

alias gclone=clone_repository $@
alias gpush=git_push $@
alias gpull=pull_repository $@
alias enact=activate_global_env $@
