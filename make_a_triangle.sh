#get three numbers from user
echo "Enter three numbers"
#if the numbers are wrong go to first of loop and get the numbers again
while true
do
    read num1
    read num2
    read num3
    #check if three numbers can make a triangle
    if [ $num1 -lt $((num2+num3)) ] && [ $num2 -lt $((num1+num3)) ] && [ $num3 -lt $((num1+num2)) ]
    then
    echo "The three numbers can make a triangle"
    #calculate the s,p of triangle
    s=$((($num1+$num2+$num3)/2))
    p=$(($s*($s-$num1)*($s-$num2)*($s-$num3)))
    #calculate the area of triangle
    area=$(echo "scale=2;sqrt($p)" | bc)
    #put p,s in test2.txt
    echo "p=$p" > test2.txt
    echo "s=$s" >> test2.txt
    #end the loop
    break
    else
    echo "The three numbers can not make a triangle" >> test1.txt
    echo "enter three numbers again"
    fi
done
#show date and hour of system
date
