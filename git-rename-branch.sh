#!/usr/bin/env bash

if [[ $# -ne 1 ]]; then
    echo "Missing new branch name."
    exit 1
fi

OLD_BRANCH_NAME=$(git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ \1/' -e 's/^[[:space:]]*//')
NEW_BRANCH_NAME=$1
git branch -m $NEW_BRANCH_NAME
git push origin :$OLD_BRANCH_NAME $NEW_BRANCH_NAME
git push origin -u $NEW_BRANCH_NAME
