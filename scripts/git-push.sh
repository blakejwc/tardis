#! /bin/bash
set -e

function usage {
  echo "Usage:"
  echo "$0 [<branchName>]"
  echo "    Branch is of the form draft-<branchName>: pushes to the remote draft branch."
  echo "    All other branches: pushes to git branch <branchName> if specified, otherwise pushes to the remote branch that the current branch is tracking."
}

function parse_git_branch {
   ref=$(git symbolic-ref HEAD 2> /dev/null) || return
   echo ${ref#refs/heads/}
}

function parse_tracking_branch {
  ref=`git config branch.$(parse_git_branch).merge 2> /dev/null` || return
  echo ${ref#refs/heads/}
}

if [ "$1" == "-h" ]
then
  usage
  exit 1
elif [[ "$(parse_git_branch)" == "draft"* ]]
then
  if [ -z "$1" ]
  then
    gitBranch=refs/drafts/$(parse_tracking_branch)
  else
    gitBranch=refs/drafts/$1
  fi
else
  if [ -z "$1"]
  then
    gitBranch=refs/for/$(parse_tracking_branch)
  else
    gitBranch=refs/for/$1
  fi
fi

git push origin HEAD:$gitBranch