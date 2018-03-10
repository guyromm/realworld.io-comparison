#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


function listfiles() {
    find $1 -type f \
	 ! -wholename '*.git/*' \
	 ! -wholename '*node_modules/*' \
	 ! -wholename '*TestCase/*' \
	 ! -wholename '*/tests/*' \
	 ! -wholename '*/migrations/*py' \
	 ! -wholename '*/migrations/*js' \
	 ! -wholename '*/migrate/*rb' \
	 ! -wholename '*www/bundle.js' \
	 ! -iname 'package-lock.json' \
	 ! -iname 'yarn.lock' \
	 ! -iname '*.pyc' \
	 -print0
}
function clocall() {
    mkdir -p $1"-results"
        for D in $(find ./$1-apps -maxdepth 1 -type d ! -iname '.' ! -iname $1'-apps') ; do
	echo "********** $D"
	listfiles $DIR/$D \
	    | xargs -0 cloc \
	    | tail -n+9 | head -n -3 | sed -E 's/^/'$(basename $D)'\t/g' \
		    > $1"-results/"$(basename $D)".txt" && \
	    sed -i -E 's/T=(.*)$//g' $1-results/$(basename $D)".txt"
    done
}

[[ $0 != "$BASH_SOURCE" ]] && sourced=1 || sourced=0
if [[ $sourced != "1" ]] ; then
    rm -rf $DIR/$1-results/*txt
    clocall $1
    #grep SUM $1-results/*txt | awk '{print $5,$1}' | sort -k1n
    (echo $'repo\tlang\tfiles\tblank\tcomment\tcode' ; cat $1-results/*txt) | tee $1-results/all.txt &&
    cat $1-results/all.txt  | termsql -0 -m tab -1 "$(cat $1'-bylang.sql')" | tee $1-results/bylang.tsv
    
fi
