#!/bin/bash
DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
rm -rf $DIR/results/*txt
for D in $(find ./apps -maxdepth 1 -type d ! -iname '.' ! -iname 'apps') ; do
    echo "********** $D"
    find $DIR/$D -type f ! -wholename '*node_modules/*' ! -wholename '*TestCase/*' ! -wholename '*/tests/*' | xargs cloc > results/$(basename $D)".txt" && \
	sed -i -E 's/T=(.*)$//g' results/$(basename $D)".txt"
done
grep SUM results/*txt | awk '{print $5,$1}' | sort -k1n
