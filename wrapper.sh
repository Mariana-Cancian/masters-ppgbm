#!/usr/bin/env bash
ARG=$1
if [ $# -eq 0 ]; then
    echo "All!"
else
    case $ARG in
        mod1)
            echo -e "\e[01m### Starting module 01 ###\e[0m"
            ;;
        mod2)
            echo -e "\e[01m### Starting module 02 ###\e[0m"
            ;;
        mod3)
            echo -e "\e[01m### Starting module 03 ###\e[0m"
            ;;
        mod4)
            echo -e "\e[01m### Starting module 04 ###\e[0m"
            ;;
        mod5)
            echo -e "\e[01m### Starting module 05 ###\e[0m"
            ;;
        *)
            echo "Invalid argument."
    esac
fi
