#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
function fetch_repos() {
TDIR=$DIR"/"$1'-apps/'
mkdir -p $TDIR

for RURL in $(cat $1-side-repos.txt) ; do
    cd $TDIR
    BN="$(basename $RURL)"
    git submodule add $RURL # $TDIR$BN
    done
}
fetch_repos $1
cd $DIR
