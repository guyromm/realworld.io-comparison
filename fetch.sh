#!/bin/bash
function fetch_repos() {
TDIR=$1'-apps/'
mkdir -p $TDIR
for RURL in $(cat $1-side-repos.txt) ; do
    BN="$(basename $RURL)"
    git clone $RURL $TDIR$BN
    done
}
fetch_repos $1
