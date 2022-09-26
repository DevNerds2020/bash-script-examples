#! /bin/bash
#from => DEVNERDS2020
# This script is used to initialize a branch
mainBranch=$1
shouldStash=$2
git pull
#should stash or not
if [ -n $shouldStash ] && [[ $shouldStash == '--stash' ]]
then
	echo "*************** stashing your changes ******************"
	git stash -u
fi
branch=$(git branch --show-current)
#get the word before / in branch name
projectName=${branch%%/*}

if [[ $projectName == 'hotfix' ]] && [ -z $mainBranch ]
then
	parentBranch="master"
elif [[ $projectName == 'feature' ]] && [ -z $mainBranch ]
then
	parentBranch="develop"
else
	parentBranch=$mainBranch
fi

echo "************* checkout $parentBranch **************"
git checkout $parentBranch
git pull
git checkout $branch
git merge $parentBranch
if [ -n shouldStash ] && [[ $shouldStash == '--stash' ]]
then
	echo "************** applying your stash ****************"
	git stash pop
fi
git push
yarn
echo "*************** branch **************"
git branch --show-current
echo "*************************************"
yarn dev