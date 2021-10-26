#!/bin/bash

arrits() {
    itens=("$@")
    for item in ${itens[@]}
    do
        bash $item || exit 1
    done
}

display_help() {
    echo -e "# $0 - Run pipeline modules"
    echo -e "   # Usage:\n\tbash $0 [argument]"
    echo ""
    echo -e "    # You can run this script without arguments or using one of the following arguments:"
    echo -e "      -m01 or --module01: run module 01 only."
    echo -e "      -m02 or --module02: run module 02 only."
    echo -e "      -m03 or --module03: run module 03 only."
    echo -e "      -m04 or --module04: run module 04 only."
    echo -e "      -f02 or --from02: run from module 02 to module 04."
    echo -e "      -f03 or --from03: run from module 03 to module 04."
    echo -e "      -h or --help: display help."
    echo ""
    echo -e "    # example 01:\n\tbash $0\n\t> By not using any arguments you run all pipeline modules."
    echo -e "    # example 02:\n\tbash $0 -m01"
}

modulos=("scripts/module01.sh" "scripts/module02.sh" "scripts/module03.sh" "scripts/module04.sh")
ARG=$1

if [ $# -eq 0 ]; then
    arrits ${modulos[@]}
else           
    case $ARG in
        -m01 | --module01)
            bash ${modulos[0]}
            ;;
        -m02 | --module02)
            bash ${modulos[1]}
            ;;
        -m03 | --module03)
            bash ${modulos[2]}
            ;;
        -m04 | --module04)
            bash ${modulos[3]}
            ;;
        -f02 | --from02)
            arrits ${modulos[@]:1}
            ;;
        -f03 | --from03)
            arrits ${modulos[@]:2}
            ;;
        -h | --help)
            display_help
            ;;
        *)
            echo "Please, enter a valid argument."
            echo "Use -h or --help to get a list of available arguments."
    esac
fi
