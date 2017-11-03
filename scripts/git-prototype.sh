#! /bin/bash
set -e

function usage {
  echo "Usage:"
  echo "$0 [<branchName>]"
  echo "    If the current git branch is of the form 'draft-*', then renames the current branch to <branchName> if specified else strips the leading 'draft-', otherwise won't do anything."
}

function parse_git_branch {
   ref=$(git symbolic-ref HEAD 2> /dev/null) || return
   echo ${ref#refs/heads/}
}

function parse_tracking_branch () {
  ref=`git config branch.$1.merge 2> /dev/null`
  if [ -z "$ref" ]
  then
    >&2 echo
    >&2 echo "error: The branch $1 has been deleted."
    exit 1
  fi
  echo ${ref#refs/heads/}
}

function recur_set_upstream () {
  ref=$(parse_tracking_branch $1)
  git branch --set-upstream-to=origin/$ref || recur_set_upstream $ref
}

if [ "$1" == "-h" ]
then
  usage
  exit 1
elif [[ "$(parse_git_branch)" == "draft"* ]]
then
  if [ -z "$1" ]
  then
    if [[ "$(parse_git_branch)" == "draft" ]]
    then
      echo "Default draft branch 'draft' requires a new branch name."
      exit 1
    else
      newName=`echo $(parse_git_branch) | sed 's/draft-//g'`
    fi
  else
    if [[ "$1" == "draft"* ]]
    then
      echo "Prototype names cannot use the same syntax as drafts i.e. 'draft*'"
      exit 1
    else
      newName=$1
    fi
  fi
else
  echo "Current branch is not a draft."
  exit 1
fi

git branch -m $newName && recur_set_upstream $(parse_git_branch)