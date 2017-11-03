#! /bin/bash
set -e

function usage {
  echo "Usage:"
  echo "$0 [<branchName>]"
  echo "    Creates a git branch draft-<branchName> that tracks the current checkout branch if specified, otherwise backs up the current draft branch and checks out a new draft branch that tracks the current branch; however, if you are on the draft branch, the draft branch will just be backed up."
}

function parse_git_branch {
   ref=$(git symbolic-ref HEAD 2> /dev/null) || return
   echo ${ref#refs/heads/}
}

if [ "$1" == "-h" ]
then
  usage
  exit 1
elif [ -z "$1" ]
then
  echo "Backing up current draft branch..."
  if [[ "$(parse_git_branch)" == "draft-"* ]]
  then
    if [ $(git rev-parse --verify backup-draft 2> /dev/null) ]
    then
      git branch -D backup-draft
    fi
    git branch backup-draft "$(parse_git_branch)"
    echo "...Created a backup of the $(parse_git_branch) branch."
  else
    if [ $(git rev-parse --verify draft 2> /dev/null) ]
    then
      if [ $(git rev-parse --verify backup-draft 2> /dev/null) ]
      then
        git branch -D backup-draft
      fi
      git branch backup-draft draft
      echo "...Created a backup of the draft branch."
      if ! [ "$(parse_git_branch)" == "draft" ]
      then
        git branch -D draft
        git checkout -b draft "$(parse_git_branch)" --track
      fi
    else
      git checkout -b draft "$(parse_git_branch)" --track
    fi
  fi
else
  git checkout -b "draft-$1" "$(parse_git_branch)" --track
fi