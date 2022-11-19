cd categorized
#array folder types
declare -a foldertypes
#a loop for always checking categorized file
while true
do
  #check the files in categorized folder 
    for file in *
    do
        if [ -f $file ]
        then
            #check the file type that is afte . like test.html
            type=$(echo $file | cut -d . -f 2)
            #make a folder with the type name if it not exists and move the file to there
            if [ ! -d $type ]
            then
            mkdir $type
            #add the folder types array
            foldertypes+=($type)
            mv $file $type
            else
            #if the folder exists move the file to there
            mv $file $type
            fi
        fi
        #if we have a directory and it is not a folder type
        if [ -d $file ] && [[ ! " ${foldertypes[@]} " =~ " ${file} " ]]
        then
            #check the directorys in the directory
            for file2 in $file/*
            do
                #if the file is a directory
                if [ -d $file2 ]
                then
                   #change the name of the directory
                     mv $file2 $file2"_dir"
                fi
            done
            #move all the directorys and files to the categorized directory force
            mv $file/* .
            #if the directory is empty delete it
            if [ -z "$(ls -A $file)" ]
            then
                    rmdir $file
            fi
        fi
    done
done
