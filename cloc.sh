#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"


function listfiles() {
    find $1 -type f \
	 ! -wholename '*.git/*' \
	 ! -wholename '*node_modules/*' \
	 ! -wholename '*TestCase/*' \
	 ! -wholename '*/tests/*' \
	 ! -wholename '*www/bundle.js' \
	 ! -iname 'package-lock.json' \
	 ! -iname 'yarn.lock'    
}
function clocall() {
        for D in $(find ./apps -maxdepth 1 -type d ! -iname '.' ! -iname 'apps') ; do
	echo "********** $D"
	listfiles $DIR/$D \
	    | xargs cloc > results/$(basename $D)".txt" && \
	    sed -i -E 's/T=(.*)$//g' results/$(basename $D)".txt"
    done
}

[[ $0 != "$BASH_SOURCE" ]] && sourced=1 || sourced=0
if [[ $sourced != "1" ]] ; then
    rm -rf $DIR/results/*txt
    clocall
    grep SUM results/*txt | awk '{print $5,$1}' | sort -k1n
fi
