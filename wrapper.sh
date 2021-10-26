#!/bin/bash

arrits() {
    itens=("$@")
    for item in ${itens[@]}
    do
        bash $item || exit 1
    done
}

display_help() {
    echo "$0 - Run pipeline modules"
    echo "Usage bash:\n$0 [argument]"
    echo ""
    echo "You can run this script without arguments or\nusing one of the following arguments:"
    echo "  -example: bash $0 m01"
    echo ""
    echo "  m01: run module 01 only."
    echo "  m02: run module 02 only."
    echo "  m03: run module 03 only."
    echo "  m04: run module 04 only."
    echo "  f02: run from module 02 to module 04."
    echo "  f03: run from module 03 to module 04."
    echo "  -h or --help: display help."
    echo ""
}

modulos=("scripts/module01.sh" "scripts/module02.sh" "scripts/module03.sh" "scripts/module04.sh")
ARG=$1

if [ $# -eq 0 ]; then
    arrits ${modulos[@]}
else           
    case $ARG in
        m01)
            bash ${modulos[0]}
            ;;
        m02)
            bash ${modulos[1]}
            ;;
        m03)
            bash ${modulos[2]}
            ;;
        m04)
            bash ${modulos[3]}
            ;;
        f02)
            arrits ${modulos[@]:1}
            ;;
        f03)
            arrits ${modulos[@]:2}
            ;;
        -h | --help)
            echo "Ajuda"
            ;;
        *)
            echo "Please, enter a valid argument."
            echo "Use -h or --help to get available a list of available arguments."
    esac
fi
