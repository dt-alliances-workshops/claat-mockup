#/bin/bash

# custom defined counts no longer used
# awsimmersioncount=7
# awsselfpacedcount=9

# Source Counts
azurecount=$(grep -lr "tags: azure" workshop-markdown/* | wc -l)
awsselfpacedcount=$(grep -lr "aws-selfpaced" workshop-markdown/* | wc -l)
awsimmersioncount=$(grep -lr "tags: aws-immersion-day" workshop-markdown/* | xargs -d '\n'  grep -L "tags: aws-immersion-day-jp" | xargs -d '\n' grep -L "tags: aws-immersion-day-SAAS" | wc -l)
awsjpcount=$(grep -lr "aws-immersion-day-jp" workshop-markdown/* | wc -l)
awssaascount=$(grep -lr "aws-immersion-day-SAAS" workshop-markdown/* | wc -l)
redhatcount=$(grep -lr "tags: openshift" workshop-markdown/* | wc -l)

# Azure Generated Count
azuregencount=$(grep -s '<a href="/codelabs' dist/azure.html | wc -l)
# AWS Generated Counts
awsselfpacedgencount=$(grep -s '<a href="/codelabs' dist/aws-selfpaced.html | wc -l)
awsimmersiongencount=$(grep -s '<a href="/codelabs' dist/aws-immersion-day.html | wc -l)
awsjpgencount=$(grep -s '<a href="/codelabs' dist/aws-immersion-day-jp.html | wc -l)
awssaasgencount=$(grep -s '<a href="/codelabs' dist/aws-immersion-day-SAAS.html | wc -l)
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

if [ $azuregencount -eq $azurecount ];
then 
	echo "Azure Passes"
else
	echo "Azure Fails"
fi

if [ $awsselfpacedgencount -eq $awsselfpacedcount ];
then 
	echo "AWS Self-Paced Passes"
else
	echo "AWS Self-Paced Fails"
fi

if [ $awsimmersiongencount -eq $awsimmersioncount ];
then 
	echo "AWS Immersion-Day Passes"
else
	echo "AWS Immersion-Day Fails"
fi

if [ $awsjpgencount -eq $awsjpcount ];
then 
	echo "AWS Immersion-Day JP Passes"
else
	echo "AWS Immersion-Day JP Fails"
fi

if [ $awssaasgencount -eq $awssaascount ];
then 
	echo "AWS Immersion-Day SAAS Passes"
else
	echo "AWS Immersion-Day SAAS Fails"
fi

if [ $redhatgencount -eq $redhatcount ];
then 
	echo "RedHat Passes"
else
	echo "RedHat Fails"
fi

