#!/bin/bash
# ---------------------------------------------------------------------------------------------
# global variables
# ---------------------------------------------------------------------------------------------

RED="\033[31m"
GREEN="\033[32m"
declare -i EXIT_CODE=1
INPUT=$@
STR_TO_COMPARE="-f /"

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

# ---------------------------------------------------------------------------------------------
# Check the option that user has been chosen: a. Password as an input. b. Password inside file
# ---------------------------------------------------------------------------------------------

checkInputCategory(){
if [ -z "$INPUT" ]; then
    echo -e $RED 'Invalid input. Please insert input in this format: {./password-validator.sh "MyPW123"} or {./password-validator.sh -f "/myPath/password.txt"}'
else
    # If chosen option to check password in file.
    if [ "${INPUT::4}" = "${STR_TO_COMPARE}" ]; then
        FILE_PATH_AND_NAME="."${INPUT:3}
        echo $FILE_PATH_AND_NAME
        # Checks if file is exists
        if [ -f "${FILE_PATH_AND_NAME}" ]; then
            PW_FROM_FILE=$(<${FILE_PATH_AND_NAME})   
            pwValidation "${PW_FROM_FILE}"
        else
            echo -e $RED "The file: $FILE_PATH_AND_NAME do not exists. Please enter valid file." 
        fi
    # If chosen option to check password as text.
    else
        pwValidation "$INPUT"
    fi
fi
}

# ---------------------------------------------------------------------------------------------
# init
# ---------------------------------------------------------------------------------------------

checkInputCategory
exit $EXIT_CODE