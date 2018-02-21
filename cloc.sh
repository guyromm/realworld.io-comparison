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
	 -print0
}
function clocall() {
        for D in $(find ./apps -maxdepth 1 -type d ! -iname '.' ! -iname 'apps') ; do
	echo "********** $D"
	listfiles $DIR/$D \
	    | xargs -0 cloc \
	    | tail -n+9 | head -n -3 | sed -E 's/^/'$(basename $D)'\t/g' \
		    > results/$(basename $D)".txt" && \
	    sed -i -E 's/T=(.*)$//g' results/$(basename $D)".txt"
    done
}

[[ $0 != "$BASH_SOURCE" ]] && sourced=1 || sourced=0
if [[ $sourced != "1" ]] ; then
    rm -rf $DIR/results/*txt
    clocall
    #grep SUM results/*txt | awk '{print $5,$1}' | sort -k1n
    (echo $'repo\tlang\tfiles\tblank\tcomment\tcode' ; cat results/*txt) | tee results/all.txt &&
    cat results/all.txt  | termsql -0 -m tab -1 "$(cat bylang.sql)" | tee results/bylang.tsv
    
fi
