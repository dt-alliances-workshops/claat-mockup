id: aws-lab4-Key Based Access
categories: 
tags: 
status: Hidden

# AWS Lab 4 - AWS Monitor with Key Access

## Overview

For intelligent monitoring of services running in Amazon cloud, you can integrate Dynatrace with Amazon Web Services (AWS). AWS integration helps you stay on top of the dynamics of your data center in the cloud.

### Objectives of this Lab

🔷 Review how Dynatrace integrates with <a href="https://aws.amazon.com/cloudwatch/" target="_blank">AWS CloudWatch</a>

🔷 Review how <a href="https://www.dynatrace.com/support/help/how-to-use-dynatrace/problem-detection-and-analysis/problem-detection/metric-events-for-alerting/" target="_blank">Metric events for alerts</a>

## AWS Dashboard

In addition to monitoring your AWS workloads using OneAgent, Dynatrace provides integration with AWS CloudWatch which adds infrastructure monitoring to gain insight even into serverless application scenarios.

### 👍 How this helps

Dynatrace brings value by enriching the data from AWS CloudWatch extending observability into the platform with additional metrics for cloud infrastructure, load balancers, API Management Services, and more.

These metrics are managed by Dynatrace's AI engine automatically and this extended observability improves operations, reduces MTTR and increases innovation. 

Here is an example from another environment.

![image](img/lab3-aws-dashboard.png)

### Hosts regional page 

Notice the following details:
1. A summary of type and status is shown
1. A running average for virtual machines
1. A table of host with AWS monitor metrics summarized.  Notice that both hosts with and without an OneAgent are both shown

![image](img/lab3-host-list.png)

### EC2 example

Here is an example of a host with no OneAgent.

Notice the following details:
1. Expand the properties to see more details
1. All the AWS CloudWatch metrics are viewable as time-series data

![image](img/lab3-host-detail.png)

### Lambda example

Here is a list of the Lambda functions.  Notice tags and time-series data.

![image](img/lab3-lambda-list.png)

### Preset dashboards

As AWS services are enabled, Dynatrace will enable preset dashboards automatically.  These can be cloned and customized or hidden as required.  Here is one example:

![image](img/lab3-preset-dashboard.png)

To see more dashboards, navigate to this repository:
* <a href="https://github.com/Dynatrace/snippets/tree/master/product/dashboarding/aws-supporting-services" target="_blank">https://github.com/Dynatrace/snippets/tree/master/product/dashboarding/aws-supporting-services</a>

## Lab Setup

There are <a href="https://www.dynatrace.com/support/help/setup-and-configuration/setup-on-cloud-platforms/amazon-web-services/aws-monitoring-with-dynatrace-managed" target="_blank">several ways</a> one can configure the Dynatrace AWS monitor, but for this workshop we will use a quick solution using AWS Key based access following these basic steps:

1. Create AWS IAM policy for monitoring
1. Add an AWS user with Programmatic access
1. Create Dynatrace AWS connection with the user AWS User Access ID and Key 

### Step 1 of 3: Create AWS IAM policy for monitoring

The AWS monitoring policy defines the minimum scope of permissions you need to give to Dynatrace to monitor the services running in your AWS account. Create it once and use anytime when enabling Dynatrace access to your AWS account.

1 . Go to `Identity and Access Management (IAM)` in your Amazon Console.

2 . Go to `Policies` menu option on left

3 . On the `Policies` page, click the `Create policy` button. 

![image](img/dt-aws-dashboard-policy.png)

4 . On the new policy page, select the `JSON` tab and paste this predefined policy from the box below from the JSON from this Dynatrace page:

* <a href="https://www.dynatrace.com/support/help/setup-and-configuration/setup-on-cloud-platforms/amazon-web-services/amazon-web-services-integrations/cloudwatch-metrics/aws-monitoring-with-dynatrace-managed#expand--key-based-access-aws-govcloud-and-aws-china-only--6" target="_blank">https://www.dynatrace.com/support/help/setup-and-configuration/setup-on-cloud-platforms/amazon-web-services/amazon-web-services-integrations/cloudwatch-metrics/aws-monitoring-with-dynatrace-managed#expand--key-based-access-aws-govcloud-and-aws-china-only--6</a>

Scroll down and expand the section `Key-based authentication (AWS GovCloud and AWS China only)`

When you are done, it should look like this

![image](img/dt-aws-dashboard-policy-json.png)

5 . You can skip over the `Add tags` page

6 . One the `Review policy` page, use the policy name of `dynatrace_monitoring_policy`

![image](img/dt-aws-dashboard-policy-name.png)

7 . Click `Create policy` button.

### Step 2 of 3: Add an AWS user with Programmatic access

Dynatrace can use access keys to make secure REST or Query protocol requests to the AWS service API. You'll need to generate an Access key ID and a Secret access key that Dynatrace can use to get metrics from Amazon Web Services.

1 . On the IAM page in the AWS console, pick the `Users` menu

2 . On the new use page, click `Add User`.

* For User Name set to `Dynatrace_monitoring_user` 
* Click the `Next:Permissions` button

Specify User Details

![image](img/CWUserDetails.png)

3 . On the set permissions page

* Click the `Attach existing policies directly` tab 
* Search and choose the monitoring policy you defined in the previous step, for example `dynatrace_monitoring_policy`
* Click the `Click Next: Review` button

![image](img/CWSetPermisions.png)

4 . You can skip over the `Add tags` page

5 . Review the user details and click `Create user`.

![image](img/CWReviewCreate.png)

6 . In order to create an Access key and Secret, we first need to access the newly created user.

![image](img/CWIAMUser.png)

7  .  Choose the Security Credentials Tab ...

![image](img/CWSecCreds.png)

8  .  and click on Create access key

![image](img/CWCreateKeys.png)

9  .  In the Access key best practices & alternatives choose the Third-party service tab, check the “I understand …” box and proceed to Next .

![image](img/CWAccessKeyBestPractices.png)

10  .  You can skip setting a description tag and directly Create access key.

11  .  You can store the Access Key ID name (AKID) and Secret access key values using any of the available methods. Be mindful of the warning up top though: This is the only time that the secret access key can be viewed or downloaded. You cannot recover it later. However, you can create a new access key any time.

![image](img/CWRetrieveAccessKey.png)

### Step 3 of 3: Start the creation of a Dynatrace AWS connection and generate connection token

Once you've granted AWS access to Dynatrace, it's time to connect Dynatrace to your Amazon AWS account.

1 . In the Dynatrace menu, go to `Settings > Cloud and virtualization > AWS` 

2 . Click `Connect new instance` button.

3 . Select `Key-based authentication` method.

* Create a name for this connection. This is mandatory. Dynatrace needs this name to identify and display the connection (For example: `dynatrace_workshop`)
* In the `Access key ID` field, paste the identifier of the key you created in Amazon for Dynatrace access.
* In the `Secret access key` field, paste the value of the key you created in Amazon for Dynatrace access.
* Click `Connect` to verify and save the connection.
* Leave the other settings as default

![image](img/dt-aws-dashboard-key.png)

4 . Once the connection is successfully verified and saved, your AWS account will be listed in the Cloud and virtualization settings page. If successful, your should see the configuration now on the AWS connections page:

![image](img/dt-aws-dashboard-list.png)

## Review AWS monitor

On the far left Dynatrace menu, navigate to the `Infrastructure -> AWS` menu.

![image](img/dt-aws-dashboard-menu.png)

You may see `no data` initially as seen here. This is because Dynatrace makes Amazon API requests every 5 minutes, so it might take a few minutes for data to show until we are done with application setup on AWS.

![image](img/dt-aws-dashboard-blank.png)

Once data is coming in, the dashboard pages will look similar to what is shown below.

![image](img/dt-aws-dashboard-overview.png)

![image](img/dt-aws-dashboard.png)

### Review collected metrics

Once data starts to be collected, click in the blue availability zone section located under the grey header labeled EC2 and you should see the list of availability zones below. Click on `us-west-2c` and the EC2 instances will be listed.

![image](img/aws-monitor-list.png)

Click on an EC2 instance, and you will see how this host still is represented in the same Host view that we saw earlier with the host running the OneAgent. The basic CPU and memory metrics from CloudWatch are graphed for you. What is GREAT, is that this host is being monitored automatically by the Dynatrace AI engine and can raise a problem when there are anomalies.

![image](img/aws-monitor-host.png)

### 👍 How this helps

The AWS monitor is a central way to get a picture and metrics for the AWS resources running against your accounts as you migrate.

Read more about how to scale your enterprise cloud environment with enhanced AI-powered observability of all AWS services in <a href="https://www.dynatrace.com/news/blog/monitor-any-aws-service/" target="_blank">this Dynatrace blog</a>

### 💥 **TECHNICAL NOTE** 

<i>See the <a href="https://www.dynatrace.com/support/help/technology-support/cloud-platforms/amazon-web-services/aws-monitoring-with-dynatrace-saas/" target="_blank">Dynatrace Docs</a> for more details on the setup options.</i>

## Custom Metrics Events

Dynatrace Davis automatically analyzes abnormal situations within your IT infrastructure and attempts to identify any relevant impact and root cause. Davis relies on a wide spectrum of information sources, such as a transactional view of your services and applications, as well as all on events raised on individual nodes within your Smartscape topology.

There are two main sources for single events in Dynatrace:

* Metric-based events (events that are triggered by a series of measurements)
* Events that are independent of any metric (for example, process crashes, deployment changes, and VM motion events)

Custom metric events are configured in the global settings of your environment and are visible to all Dynatrace users in your environment.

### 1. Setup Custom metric alerting for AWS

1 . To add custom alerts, navigate to `Settings --> Anomaly Detection --> Metric events` menu. 

2 . Click the `Add metric events` button.

![image](img/addmetricevent.png)

3 . Fill in the below information on the `Add metric event` template
1.  Summary:  `CPU % percentage`
2.  Type:  `Metric key` from dropdown
3.  Metric key `EC2 CPU usage %` from dropdown
4.  Agregation `Average` from dropdown
5.  Management zone `dt-orders-monolith`
6.  under entities click on `>` to see `Dimension key of entity type` and select `EC2 instance` from dropdown

![image](img/dimensionkey.png)

7.  Dymension filter click on `Add dimension filter` and select as shown below.

![image](img/adddimensionfilter.png)

8.  under Monitoring strategy section select as shown.

![image](img/monotoringstrategy.png)

9.  select the `>` next to `Advanced model properties` and input as shown.

![image](img/advancedmodelproperties.png)

10. In the `Event template` section add:
    1. Title:  `CPU CUSTOM ALERT`
    2. Event type from dropdown:  `Custom alert`
    3. Dimension key of entity for events select `EC2 instance` from dropdown

![image](img/keydimensionofentity.png)

11. click on `Save Changes`

4 . Add another rule, with everything the same, except for the `Event Description` to have the `title` as `CPU Resource Alert` and `Event type` = `RESOURCE` as shown below. 
  1. toggle the `Alert on missing data` to `off`

![image](img/eventtemplate.png)

5 . Save your changes and the list should look as shown below.

![image](img/savedmetricevents.png)

## Trigger Custom Problem Alerts

### 1. SSH to monolith host 

To connect to the host, simply use `EC2 Instance Connect`.  To this, navigate to the `EC2 instances` page in the AWS console.

From the list, pick the `dt-orders-monolith` and then the `connect` button.

![image](img/aws-ec2-connect-list.png)

Then on the next page, choose the `EC2 Instance Connect` option and then the `connect` button.

![image](img/aws-ec2-connect.png)

Once you connected, you will see the terminal prompt like the below.

```
Welcome to Ubuntu 20.04.2 LTS (GNU/Linux 5.4.0-1045-aws x86_64)
...
...
To run a command as administrator (user "root"), use "sudo <command>".
See "man sudo_root" for details.
ubuntu@ip-10-0-0-118:~$ 
```

### 2. Trigger a CPU problem

Using a unix utility <a href="https://linuxconfig.org/how-to-stress-test-your-cpu-on-linux" target="_blank">yes</a>, we can generate CPU stress just by running the `yes` command a few times.

In the terminal, copy all these lines and run them:

```
yes > /dev/null &
yes > /dev/null &
yes > /dev/null &
```

To verify, run this command:

```
ps -ef | grep yes
```

The output should look like this:

```
ubuntu    5802  5438 99 20:48 pts/0    00:00:05 yes
ubuntu    5805  5438 89 20:48 pts/0    00:00:04 yes
ubuntu    5806  5438 97 20:48 pts/0    00:00:03 yes
ubuntu    5818  5438  0 20:48 pts/0    00:00:00 grep --color=auto yes
```
3 . Back in Dynatrace within the `host` view, the CPU should now be high as shown below

![image](img/lab4-cpu.png)

4 . It may take a minute or so, but you will get two problem cards as shown below.  #1 is the alert from the `severity = RESOURCE` where Davis was invoked, and #2 is the alert from `severity = CUSTOM ALERT`.

![image](img/lab4-custom-alert-problems.png)

### 3. Review Problem Notifications

1 . Navigate to `Settings --> Integrations --> Problem Notifications` 

2 . Read the overview and then click the `Add Notification` button

3 . Click various `Notification types` from the drop down to review the configurations inputs.

4 . For the `Custom integration` type, review the option to customize the payload.

5 . Notice how you can choose the `Alert profile`, but you only have default

### 4. Review Alerting Profiles

1 . Navigate to `Settings --> Alerting --> Alerting profiles`

2 . Read the overview and then expand the `default` rule.

3 . Now add one, by clicking on the `Add alerting profile` button

4 . Review the options to choose severity rules and filters

### 5. Stop the CPU problem

To stop the problem, you need to `kill` the processes.  To do this:

1 . Back in the CloudShell, run this command to get the process IDs `ps -ef | grep yes`

2 . For each process, copy the process ID and run `kill <PID>`

For example:

```
# If output is this...

ubuntu@ip-10-0-0-118:~$ ps -ef | grep yes
ubuntu    5802  5438 99 20:48 pts/0    00:00:05 yes
ubuntu    5805  5438 89 20:48 pts/0    00:00:04 yes
ubuntu    5806  5438 97 20:48 pts/0    00:00:03 yes

# Then run...

kill 5802
kill 5805
kill 5806
```
Or use the below command to kill all the PID's at once
```
kill $(ps -ef | grep yes | awk '{print $2}' | sed '$d')
```

3 . Verify they are gone by running this again `ps -ef | grep yes`

4 . Verify that CPU in Dynatrace goes to normal and the problems will eventually automatically close

### 6. Exit the SSH

Simply type `exit` to exit the VM and return the CloudShell.

### 💥 **TECHNICAL NOTE** 

* Alert configuration is available through the <a href="https://www.dynatrace.com/support/help/dynatrace-api/configuration-api/anomaly-detection-api/anomaly-detection-api-metric-events/" target="_blank">Anomaly detection—metric events API</a>. Using the API, you can list, update, create, and delete configurations.

## Summary

In this section, you should have completed the following:

✅ Review how Dynatrace integrates with <a href="https://aws.amazon.com/cloudwatch/" target="_blank">AWS CloudWatch</a>

✅ Review how <a href="https://aws.amazon.com/cloudwatch/" target="_blank">AWS CloudWatch</a> metrics can be configured as <a href="https://www.dynatrace.com/support/help/how-to-use-dynatrace/problem-detection-and-analysis/problem-detection/metric-events-for-alerting/" target="_blank">Metric events for alerts</a>

### AWS Control Tower

The Dynatrace integrated solution for AWS Control Tower provides a way to establish Dynatrace monitoring for multi-account AWS environments. This solution automates the configuration process when AWS managed accounts are created. By ingesting metrics published to Amazon CloudWatch (Watch) for databases, networks, and compute services, Dynatrace provides a picture of your environment.  

You can read more about this on this [AWS Marketplace blog](https://aws.amazon.com/blogs/awsmarketplace/increasing-observability-in-your-aws-control-tower-landing-zone-with-dynatrace/)s
