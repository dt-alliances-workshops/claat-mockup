#/bin/bash

# custom defined counts:
awsimmersioncount=7
awsselfpacedcount=9

azurecount=$(find ./workshop-markdown -mindepth 1 -maxdepth 1 -name "azure*" -type d | wc -l)
awscount=$(find ./workshop-markdown -mindepth 1 -maxdepth 1 -name "aws*" -type d | wc -l)
redhatcount=$(find ./workshop-markdown -mindepth 1 -maxdepth 1 -name "redhat*" -type d | wc -l)

azureclcount=$(grep '<a href="/codelabs' dist/azure.html | wc -l)
awsimmersionclcount=$(grep '<a href="/codelabs' dist/aws-immersion-day.html | wc -l)
awsselfpacedclcount=$(grep '<a href="/codelabs' dist/aws-selfpaced.html | wc -l)
redhatclcount=$(grep '<a href="/codelabs' dist/openshift.html | wc -l)

echo "Azure Codelab arkdown count=${azurecount}"
echo "AWS Codelab markdown count=${awscount}"
echo "RedHat Codelab markdown count=${redhatcount}"

echo "Azure generataed lab count=${azureclcount}"
echo "AWS Immersion Day generated lab count=${awsimmersionclcount}"
echo "AWS Self-Paced generated lab count=${awsselfpacedclcount}"
echo "RedHat generated lab count=${redhatcount}"

if [ $azureclcount -eq $azurecount ];
then 
	echo "Azure Passes"
else
	echo "Azure Fails"
	exit 1
fi

if [ $awsimmersionclcount -eq $awsimmersioncount ];
then 
	echo "AWS Immersion-Day Passes"
else
	echo "AWS Immersion-Day Fails"
	exit 1
fi


if [ $awsselfpacedclcount -eq $awsselfpacedcount ];
then 
	echo "AWS Self-Paced Passes"
else
	echo "AWS Self-Paced Fails"
	exit 1
fi


if [ $redhatclcount -eq $redhatcount ];
then 
	echo "RedHat Passes"
else
	echo "RedHat Fails"
	exit 1
fi

