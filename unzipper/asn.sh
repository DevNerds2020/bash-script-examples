#! /bin/bash
<<com
    this file is getting a password.txt file from user then check all the passwords for unziping the target file
    and then gets a numbers.txt file from unziped folder and then sort all the numbers in it
com
#loop in passwords.txt lines and get each password and try to unzip assignment.zip with it
while read line
do
    echo $line
    unzip -P $line assignment.zip
    if [ $? -eq 0 ]
    then
        echo "Password is $line"
        break
    fi
done < passwords.txt
#put numbers.txt file data seprated with comma in an array
IFS=',' read -r -a array <<< $(cat assignment/numbers.txt)
#echo the array
echo ${array[@]}
#sort the array in increasing order with algorithm
for ((i=0; i<${#array[@]}; i++))
do
    for ((j=i+1; j<${#array[@]}; j++))
    do
        if [ ${array[i]} -gt ${array[j]} ]
        then
            temp=${array[i]}
            array[i]=${array[j]}
            array[j]=$temp
        fi
    done
done
#put the sorted array in a file
# echo ${array[@]} > assignment/sorted.txt
#put the sorted array in a file with comma seprated
# echo ${array[@]} | tr ' ' ',' > assignment/sorted.txt
#put the sorted array in a file with comma seprated and remove the last comma
# echo ${array[@]} | tr ' ' ',' | sed 's/,$//' > assignment/sorted.txt
echo ${array[@]}

#sort the array in increasing order (a better and easier way)
sorted_array2=($(for i in "${array[@]}"; do echo $i; done | sort -n))
echo "=> ${sorted_array2[@]}"