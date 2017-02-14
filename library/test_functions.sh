#!/bin/bash

# Created by Sujay Davalgi
#
# test functions-library for other scripts
#
# Usage: ".  ./mainFunctions.sh" within other scripts

function functionsOperations(){
#$return - 
    echo " echo from ${FUNCNAME[0]} in test_functions.sh"
    
    echo "1 $( basename ${0} )"
    echo "2 ${0}"
    echo "3 ${0%/*}"
    echo "4 ${0##*/}"
    echo "5 ${BASH_SOURCE}"
    echo "6 $(basename ${BASH_SOURCE})"
    echo "7 $(basename $(readlink -nf ${0}))"
    echo "8 $(basename $(readlink -nf ${BASH_SOURCE}))"
    echo "9 $(readlink --canonicalize --no-newline $BASH_SOURCE)"
    echo "10 $(basename $(readlink --canonicalize --no-newline $BASH_SOURCE))"
    echo "11 ${BASH_SOURCE[${#BASH_SOURCE[@]} - 1]}"
    echo "12 $(cd `dirname $0` && pwd)"
    echo "13 $( dirname ${0} )"
    
}
