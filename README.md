# week2_projectv0

# ------------------------------------------------------------------------
# ReadMe 
# ------------------------------------------------------------------------

#To see the exit code in CLI enter: echo $?

# For auto testing, you can use this script:
    #!/bin/bash

    ##declare an array variable

    declare -a ARR=("sdfsdfsdfsfs" "45454545454" "454545sdfsdf45454" "454545454DDD54" "sdfsdfsdfsdfsA" "sdfs56A" "sdfsfs56A" "sdfssfs56A" "sdfss2fs56A")

    ##now loop through the above array

    for pw in "${ARR[@]}"
        do
        bash password-validator.sh "$pw"
        echo -e "pw from text: exitCode=$? $pw\n"

        done

