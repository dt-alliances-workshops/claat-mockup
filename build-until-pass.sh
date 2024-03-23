#!/bin/bash

testcounts(){
# Source Counts
azurecount=$(grep -lr "tags: azure" workshop-markdown/* | wc -l)
awsselfpacedcount=$(grep -lr "aws-selfpaced" workshop-markdown/* | wc -l)
awsimmersioncount=$(grep -lr "aws-immersion-day" workshop-markdown/* | xargs -d '\n'  grep -L "tags: aws-immersion-day-jp" | xargs -d '\n' grep -L "tags: aws-immersion-day-saas" | wc -l)
awsjpcount=$(grep -lr "aws-immersion-day-jp" workshop-markdown/* | wc -l)
awssaascount=$(grep -lr "aws-immersion-day-saas" workshop-markdown/* | wc -l)
redhatcount=$(grep -lr "tags: openshift" workshop-markdown/* | wc -l)

# Azure Generated Count
azuregencount=$(grep -s '<a href="/codelabs' dist/azure.html | wc -l)
# AWS Generated Counts
awsselfpacedgencount=$(grep -s '<a href="/codelabs' dist/aws-selfpaced.html | wc -l)
awsimmersiongencount=$(grep -s '<a href="/codelabs' dist/aws-immersion-day.html | wc -l)
awsjpgencount=$(grep -s '<a href="/codelabs' dist/aws-immersion-day-jp.html | wc -l)
awssaasgencount=$(grep -s '<a href="/codelabs' dist/aws-immersion-day-saas.html | wc -l)
# RedHat GEnerated Count
redhatgencount=$(grep -s '<a href="/codelabs' dist/openshift.html | wc -l)

echo "############# Markdown Counts ###############"
echo "Azure markdown count=${azurecount}"
echo "AWS Selfpaced markdown count=${awsselfpacedcount}"
echo "AWS ImmersionDay markdown count=${awsimmersioncount}"
echo "AWS ImmersionDay Japan markdown count=${awsjpcount}"
echo "AWS ImmersionDay SAAS markdown count=${awssaascount}"
echo "RedHat Codelab markdown count=${redhatcount}"
echo "#############################################"
echo "############# Generated Counts ##############"
echo "Azure generated lab count=${azuregencount}"
echo "AWS Self-Paced generated lab count=${awsselfpacedgencount}"
echo "AWS Immersion Day generated lab count=${awsimmersiongencount}"
echo "AWS Immersion Day JP generated lab count=${awsjpgencount}"
echo "AWS Immersion Day SAAS generated lab count=${awssaasgencount}"
echo "RedHat generated lab count=${redhatgencount}"
echo "#############################################"

# populating testing.csv
echo "${azurecount},${azuregencount},${awsselfpacedcount},${awsselfpacedgencount},${awsimmersioncount},${awsimmersiongencount},${awsjpcount},${awsjpgencount},${awssaascount},${awssaasgencount},${redhatcount},${redhatgencount}" >> testing.csv

if [ $azuregencount -eq $azurecount ];
then 
	echo "Azure Passes"
else
	echo "Azure Fails"
	return 1
fi

if [ $awsselfpacedgencount -eq $awsselfpacedcount ];
then 
	echo "AWS Self-Paced Passes"
else
	echo "AWS Self-Paced Fails"
	return 1
fi

if [ $awsimmersiongencount -eq $awsimmersioncount ];
then 
	echo "AWS Immersion-Day Passes"
else
	echo "AWS Immersion-Day Fails"
	return 1
fi

if [ $awsjpgencount -eq $awsjpcount ];
then 
	echo "AWS Immersion-Day JP Passes"
else
	echo "AWS Immersion-Day JP Fails"
	return 1
fi

if [ $awssaasgencount -eq $awssaascount ];
then 
	echo "AWS Immersion-Day SAAS Passes"
else
	echo "AWS Immersion-Day SAAS Fails"
	return 1
fi

if [ $redhatgencount -eq $redhatcount ];
then 
	echo "RedHat Passes"
else
	echo "RedHat Fails"
	return 1
fi
return 0
}

max_attempts=20
attempts=0

while :; do
	# Increment the attempt counter
	((attempt++))
	echo "Attempt $attempt of $max_attempts"

	# execute the docker build commmand
	# docker run -it -v ${PWD}/workshop-markdown:/usr/src/app/workshop-markdown -v ${PWD}/dist:/usr/src/app/dist-final mvilliger/workshop-builder:0.3
	docker run -it -v ${PWD}/workshop-markdown:/usr/src/app/workshop-markdown -v ${PWD}/dist:/usr/src/app/dist-final -v ${PWD}/app:/usr/src/app/app mvilliger/workshop-builder:0.4

	# Execute the test the built content for completeness
	testcounts

	# Check the status of the last command executed
	if [[ $? -eq 0 ]]; then
		echo "Build executed successfully in ${attempt} attempts. Exiting."
		break
	else
		echo "Testing failed."
	fi

	# Check if maximum attempts have been reached
	if [[ $attempt -eq $max_attempts ]]; then
		echo "Reached maximum attempts. Exiting."
		break
	fi

	# Optional: Sleep for a bit before trying again
	# sleep 1
done
