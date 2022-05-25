#!/bin/bash
# ---------------------------------------------------------------------------------------------
# global variables
# ---------------------------------------------------------------------------------------------

RED="\033[31m"
GREEN="\033[32m"
declare -i EXIT_CODE=1
INPUT=$@

# ---------------------------------------------------------------------------------------------
# pwValidation // checks validation of the password
# ---------------------------------------------------------------------------------------------

pwValidation() {

local PASSWORD="$1"

if [ ${#PASSWORD} -ge 10 ]; then
    if [[ $PASSWORD =~ [0-9] ]];then
        if [[ "$PASSWORD" =~ [[:upper:]] ]]; then
            if [[ "$PASSWORD" =~ [[:lower:]] ]]; then
                EXIT_CODE=0
                echo -e $GREEN "The password is valid."
            else
                echo -e $RED "Please include minimum one lower case char in the password.Your input:$PASSWORD"
            fi
        else
            echo -e $RED "Please include minimum one capital char in the password.Your input:$PASSWORD"
        fi
    else
        echo -e $RED "Please include minimum one number in the password.Your input:$PASSWORD"
    fi
else
    echo -e $RED "Please input password with minimum 10 chars length.Your input:$PASSWORD"
fi

}

if [ -z "$INPUT" ]; then
    echo -e $RED 'Invalid input. Please insert input in this format: {./password-validator.sh "MyPW123"}'

else
    pwValidation "$INPUT"
fi