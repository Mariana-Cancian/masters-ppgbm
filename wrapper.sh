#!/bin/bash

arrits() {
    itens=("$@")
    for item in ${itens[@]}
    do
        bash $item || exit 1
    done
}


modulos=("scripts/module01.sh" "scripts/module02.sh" "scripts/module03.sh" "scripts/module04.sh")
ARG=$1

if [ $# -eq 0 ]; then
    arrits ${modulos[@]}
else           
    case $ARG in
        s01)
            bash ${modulos[0]}
            ;;
        s02)
            bash ${modulos[1]}
            ;;
        s03)
            bash ${modulos[2]}
            ;;
        s04)
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
