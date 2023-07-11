id: aws-lab8-K8 events
categories: kubernetes,SAAS
tags: aws-immersion-day,aws-selfpaced,aws-immersion-day-SAAS
status: Published

# AWS Lab 8 - Kubernetes Events

## Overview

### View events
After enabling the Kubernetes event monitoring, you can view and analyze events from the Kubernetes cluster. On your Kubernetes cluster details page, go to Events.

In the Dynatrace Kubernetes dashboard, these events will look like this: 

![image](img/boom-events.png)

## Configure Event Monitoring

### Kubernetes events monitoring for analysis and alerting
For full observability into your Kubernetes events, automatic Davis analysis, and custom alerting, you need to enable Kubernetes event monitoring.

You can enable this feature for specific Kubernetes clusters. See below for instructions.

### Enable event monitoring for individual clusters
1. In the Dynatrace menu, go to Kubernetes.
2. Find your Kubernetes cluster, and then select More (…) > Settings in the Actions column.

![image](img/boom7.png)

3. Make sure that the flags are same as image.  Also click on the "add events field selector" button and add the below text to the "Field selector name" and "field selector expresion"
    ```
    Pod events

    ```

    ```
    involvedObject.kind=Pod
    ```
    
![image](img/boom8.png)

4. Select Save Changes



## Event Monitoring 

As you saw before in Lab 7 you are able to see all the same metricsw and work loads namespaces as before with the added visibility to Events specific to your environment.

**1 - Cluster Info**

![image](img/Boom1.png)

**2 - Workload detail**

![image](img/boom4.png)

**3 - Overview of the Boom-App workload**

![image](img/boom5.png)

**4 - Events specific to failed containers**

![image](img/boom2.png)

**5 - Event Metadata**

![image](img/boom3.png)
