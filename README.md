# week2_projectv0 

# ------------------------------------------------------------------------
# ReadMe 
# ------------------------------------------------------------------------

#To see the exit code in CLI enter: echo $?

# For auto testing, you can use this script:
    #!/bin/bash

    ##declare an array variable

    declare -a ARR=("sdfsdfsdfsfs" "45454545454" "454545sdfsdf45454" "454545454DDD54" "sdfsdfsdfsdfsA" "sdfs56A" "sdfsfs56A" "sdfssfs56A" "sdfss2fs56A")

    ##if file do not exists, create it

    if ! [ -f "./mypath/password.txt" ]; then
        mkdir mypath
        touch mypath/password.txt
        chmod +x mypath/password.txt
    fi

    ##now loop through the above array

    for pw in "${ARR[@]}"
        do
        bash password-validator.sh "$pw"
        echo -e "pw from text: exitCode=$? $pw\n"

        echo "$pw" > ./mypath/password.txt
        bash password-validator.sh -f "/mypath/password.txt"
        echo -e "pw from file: exitCode=$? $pw\n"

        done

