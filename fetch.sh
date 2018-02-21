#!/bin/bash
TDIR='apps/'
mkdir -p $TDIR
for RURL in $(cat server-side-repos.txt) ; do
    BN="$(basename $RURL)"
    git clone $RURL $TDIR$BN
    done
