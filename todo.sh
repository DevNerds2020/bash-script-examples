#! /bin/bash
command=$1
taskNameOption=$2
taskName=$3
taskPriorityOption=$4
taskPriority=$5
#show all the values
# echo "command = $command"
# echo "taskNameOption = $taskNameOption"
# echo "taskName = $taskName"
# echo "taskPriorityOption = $taskPriorityOption"
# echo "taskPriority = $taskPriority"
if [ $command = "clear" ]; then
    #it should clear all tasks from tasks.csv
    echo "" > tasks.csv
elif [ $command = "add" ]; then
    #add task to tasks.csv with this format 0,H,"First Task"
    if [[ -z $taskName ]]; then
        echo "Option -t|--title Needs a Parameter"
        exit 1
    fi
    if [ -n "$taskPriorityOption" ] ; then
        if [ -n $taskPriority ] && [ $taskPriority != "L" ] && [ $taskPriority != "M" ] && [ $taskPriority != "H" ]; then
            echo "Option -p|--priority Only Accept L|M|H"
            exit 1
        fi
        #get length of tasks.csv rows
        rowCount=$(wc -l tasks.csv | awk '{print $1}')
        echo "$rowCount,$taskPriority,\"$taskName\"" >> tasks.csv
    else
        #get length of tasks.csv rows
        rowCount=$(wc -l tasks.csv | awk '{print $1}')
        echo "0,L,\"$taskName\"" >> tasks.csv
    fi
elif [ $command = "list" ]; then
    #simply show tasks like this line by line rownumber | 0 | priority | taskname
    #get length of tasks.csv rows
    rowCount=$(wc -l tasks.csv | awk '{print $1}')
    #loop in rows
    for (( i=1; i<=$rowCount; i++ ))
    do
        #get row
        row=$(sed -n "$i"p tasks.csv)
        #split row by ,
        IFS=',' read -r -a array <<< "$row"
        echo "$i | ${array[0]} | ${array[1]} | ${array[2]}"
    done
elif [ $command = "find" ]; then
    #just find the task and echo it
     #get length of tasks.csv rows
    rowCount=$(wc -l tasks.csv | awk '{print $1}')
    #loop in rows
    for (( i=1; i<=$rowCount+1; i++ ))
    do
        #get row
        row=$(sed -n "$i"p tasks.csv)
        #split row by ,
        IFS=',' read -r -a array <<< "$row"
        if [ ${array[2]} = "\"$taskNameOption\"" ]; then
            echo "$i | ${array[0]} | ${array[1]} | ${array[2]}"
        fi
    done
elif [ $command = "done" ]; then
    #just change the first column to 1
    #get length of tasks.csv rows
    rowCount=$(wc -l tasks.csv | awk '{print $1}')
    #loop in rows
    for (( i=1; i<=$rowCount+1; i++ ))
    do
        #get row
        row=$(sed -n "$i"p tasks.csv)
        #split row by ,
        IFS=',' read -r -a array <<< "$row"
        if [[ ${array[2]} = "\"$taskNameOption\"" ]]; then
           #replace row
            sed -i "$i s/0/1/" tasks.csv
        fi
    done
    #show all tasks
    #get length of tasks.csv rows
    rowCount=$(wc -l tasks.csv | awk '{print $1}')
    #loop in rows
    for (( i=1; i<=$rowCount; i++ ))
    do
        #get row
        row=$(sed -n "$i"p tasks.csv)
        #split row by ,
        IFS=',' read -r -a array <<< "$row"
        echo "${array[0]},${array[1]},${array[2]}"
    done
else
    echo "Command Not Supported!"
fi
