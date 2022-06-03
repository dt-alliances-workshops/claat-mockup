id: aws-lab9
categories: kubernetes, modernization
status: Published
tags: aws-immersion-day,aws-selfpaced

# Lab 9 - DevSecOps Events

## Overview

### What is DevSecOps?

In practice, DevSecOps is a tactical trifecta that connects three different disciplines:

1. - Development
1. - Security
1. - Operations

The goal is to seamlessly integrate security into your continuous integration and continuous delivery (CI/CD) pipeline in both pre-production (dev) and production (ops) environments. 

To find out more about each discipline in more depth and the role it plays in delivering better, more secure software faster please follow the link below to the Dynatrace blog.<a href="https://www.dynatrace.com/news/blog/what-is-devsecops/" target="_blank">Dynatrace blog</a>


![image](img/DevSec1.png)

## Boom-App Deploy

<!--
### 1. Make sure you are in the correct region 

Click the region button in the top right corner of your AWS console and make sure you are in `Oregon us-west-2` for consistency in this lab.

![image](img/lab2-change-region.png)
-->

### 1. Open up Cloudshell

In this lab, we will be using AWS Cloudshell.  Make sure you are in the right directory and region of your AWS console.

To open the Cloudshell, click on the Cloudshell icon at the top of the AWS console.  This make take a minute to complete.

![image](img/DevSec1.png)

This may open up a slash page. 

![image](img/DevSec1.png)

After closing the pop-up, wait a minute for the Cloudshell to initialize.  When this is done, you will see the command prompt as shown below.

![image](img/DevSec1.png)

### 2. Deploy the Boom App

1  Once you have the Cloudshell open, you need switch to the right directory.  Run this command:

```
cd ~/aws-modernization-dt-orders-setup/app-scripts
```

2  Next run the below kubectl comand to create the boom-app namespace:
```
kubectl create ns boom-app
```

3  Next run the below kubectl comand to execute the boom-app.yaml file:
```
kubectl apply -f boom-app.yaml -n boom-app

```

4  Next run the below kubectl comand to validate that your pods have deployed and are running.
```
kubectl -n boom-app get pods -l app=boom-app -w

```
Kubectl output shows the pod crashing and restarting
![image](img/DevSec1.png)


## Configure Event Monitoring

### Kubernetes events monitoring for analysis and alerting
For full observability into your Kubernetes events, automatic Davis analysis, and custom alerting, you need to enable Kubernetes event monitoring.

You can enable this feature for specific Kubernetes clusters. See below for instructions.

### Enable event monitoring for individual clusters
1. In the Dynatrace menu, go to Kubernetes.
2. Find your Kubernetes cluster, and then select More (…) > Settings in the Actions column.

![image](img/DevSec1.png)
3. Make sure that the flags are same as image.  Also click on the "add events field selector" button and add the below text to the "Field selector name" and "field selector expresion"
    ```
    Pod events

    ```

    ```
    involvedObject.kind=Pod
    ```
    
![image](img/DevSec1.png)

4. Select Save Changes



## Event Monitoring 

As you saw before in Lab 7 you are able to see all the same metricsw and work loads namespaces as before with the added visibility to Events specific to your environment.

**1 - Cluster Info**

![image](img/DevSec1.png)
**2 - Workload detail**

![image](img/DevSec1.png)
**3 - Overview of the Boom-App workload**

![image](img/DevSec1.png)
**4 - Events specific to failed containers**

![image](img/DevSec1.png)
**5 - Event Metadata**

![image](img/DevSec1.png)

## Clean up the Boom-App
Lets make sure to clean up the Boom-App installation:

1.  To remove the namespace, run this command

```
kubectl delete ns boom-app
```

2.  Verify the namespace is removed, run this command

```
kubectl get ns
```
