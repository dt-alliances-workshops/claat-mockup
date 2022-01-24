id: aws-lab6
categories: aws
status: Published
tags: modernization


# Lab 6 - Modernization Kubernetes

## Overview

Re-hosting (also referred to as lift and shift) is a common migration use case. Re-architecture and Re-platform are steps that break the traditional architectures and replace individual components with cloud services and microservices. 

For this lab you are going to use an updated version of the application on a Kubernetes.  This makes it easy for you to see the transformation of the Sample Application in Lab 1 and the value of running Kubernetes on AWS without needing to stand up or maintain your own Kubernetes control plane. 

If you would rather NOT provision Kubernetes on AWS, then please follow the `Lab 2 - Containers` workshop guide. This guide has a shorter setup process but, still allows you to interact with the sames transformed application. 

### Objectives of this Lab 

🔷 Install the Dynatrace Operator and sample application

🔷 Review how the sample application went from a simple architecture to multiple services 

🔷 Examine the transformed application using service flows and back traces 

## Lab Setup

For this lab, another version of the application exists that breaks out each of these backend services into separate services. By putting these services into Docker images, we gain the ability to deploy the service into modern platforms like Kubernetes and AWS services.

### Kubernetes

Kubernetes is open source software that allows you to deploy and manage containerized applications at scale. 

Kubernetes manages clusters of compute instances and runs containers on those instances with processes for deployment, maintenance, and scaling. Using Kubernetes, you can run any type of containerized applications using the same toolset on-premises and in the cloud.  

You can read more about Kubernetes <a href="https://aws.amazon.com/kubernetes" target="_blank">here</a>

### Amazon Elastic Kubernetes Service

AWS makes it easy to run Kubernetes. You can choose to manage Kubernetes infrastructure yourself with Amazon EC2 or get an automatically provisioned, managed Kubernetes control plane with <a href="https://aws.amazon.com/eks/" target="_blank">Amazon EKS</a>. Either way, you get powerful, community-backed integrations to AWS services like VPC, IAM, and service discovery as well as the security, scalability, and high-availability of AWS.

Amazon EKS runs Kubernetes control plane instances across multiple Availability Zones to ensure high availability. Amazon EKS automatically detects and replaces unhealthy control plane instances, and it provides automated version upgrades and patching for them.

Amazon EKS is also integrated with many AWS services to provide scalability and security for your applications, including the following:

* Elastic Load Balancing for load distribution
* IAM for authentication
* Amazon VPC for isolation
* Amazon ECR for container images

### Lab components

Refer to the picture below, here are the components for lab 2.

![image](img/lab2-setup.png)

**#1 . Sample Application**
Sample app representing a "services" architecture of a frontend and multiple backend services implemented as Docker containers that we will review in this lab.

**#2 . Kubernetes**
Amazon Elastic Kubernetes Service (EKS) is hosting the application. The Kubernetes cluster had the Dynatrace OneAgent Operator installed. (see below for more details).  Two EKS nodes make up the Kubernetes cluster. The Dynatrace OneAgent was preinstalled by the OneAgent operator and is sending data to your Dynatrace SaaS environment. (see below for more details)

**#3 . Dynatrace Operator**
Dynatrace OneAgent is container-aware and comes with built-in support for out-of-the-box monitoring of Kubernetes. Dynatrace supports full-stack monitoring for Kubernetes, from the application down to the infrastructure layer.

**#4 . Dynatrace**
Dynatrace tenant where monitoring data is collected and analyzed.

**#5 . Full-Stack Dashboard**
Made possible by the Dynatrace OneAgent that will automatically instrument each running node & pod in EKS.

**#6 . Kubernetes Dashboard**
The Kubernetes page provides an overview of all Kubernetes clusters showing monitoring data like the clusters’ sizing and utilization.

## Lab pre-requisites

This step extends what you did in the previous step and will provision an Amazon Elastic Kubernetes Service (EKS) cluster and the Dynatrace configuration needed for the workshop.

There are the following setup steps for this lab:
1. Install the pre-requisite tools
1. Setup Dynatrace config
1. Create Cluster
1. Verify Cluster
1. Install Dynatrace Kubernetes Operator
1. Install sample application

NOTE: The step `Create Cluster` will take ~30 minutes to complete while the EKS cluster is provisioning.

### Install the pre-requisite tools

1 . From the AWS Cloudshell, create a new folder in your home directory

```
mkdir -p $HOME/bin 
```

2 . Install `kubectl`. Kubernetes uses this command line utility for communicating with the cluster API server. You can find out more by checking out the documentation

 * <a href="https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html" target="_blank">https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html</a>

 ```
 curl --silent -o $HOME/bin/kubectl https://amazon-eks.s3-us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/kubectl 
 ```

3 . Change the permissions of the new folder to make it executable

```
chmod +x $HOME/bin/kubectl 
```

4 . check to make sure it installed properly by checking the version

```
kubectl version --short --client 
```

## Setup Dynatrace config

From the AWS Cloudshell window, run these commands:

```
cd ~/aws-modernization-dt-orders-setup/workshop-config
./setup-workshop-config.sh cluster
```

The script output will look like this:

```
-----------------------------------------------------------------------------------
Setting up Workshop config
Dynatrace  : https://XXXXX.live.dynatrace.com
Starting   : Fri Oct  1 19:46:19 UTC 2021
-----------------------------------------------------------------------------------
...
...
-----------------------------------------------------------------------------------
Done Setting up Workshop config
End: Fri Oct  1 19:46:31 UTC 2021
-----------------------------------------------------------------------------------
```

The script will run fast while it adds the following Dynatrace configuration: 

* Add <a href="https://www.dynatrace.com/support/help/how-to-use-dynatrace/management-zones/" target="_blank">Management Zones</a> for the kubernete versions of the application
* Add <a href="https://www.dynatrace.com/support/help/how-to-use-dynatrace/service-level-objectives/" target="_blank">SLOs</a> for a use in custom dashboards
* Add <a href="https://www.dynatrace.com/support/help/how-to-use-dynatrace/process-groups/configuration/customize-the-name-of-process-groups/" target="_blank">Process Naming Rule</a> to have the services show as namespace-service-name

## Create Cluster

If you are at an AWS event and using an AWS event engine code, your cluster may have been automatically created in advance and you can skip this page and proceed to the `Verify Cluster` page.

If you are at not at an AWS event or you do not have a cluster, then follow these steps to setup you cluster.

### Using eksctl to create your cluster 

When you run the eksctl command below to create your cluster, it create a CloudFormation script for you.  This CloudFormation will the take 20-30 minutes to fully provision and you can monitor the status with the AWS console.

1 . Copy the `eksctl create cluster ...` command below and run it.

```
eksctl create cluster --with-oidc --ssh-access --version=1.21 --managed --name dynatrace-workshop --tags "Purpose=dynatrace-modernization-workshop" --ssh-public-key <YOUR-Key Pair-NAME>
```

It is OK when you get an error like this...

```
bash: syntax error near unexpected token `newline'
```

...because you **MUST** replace the argument value for `--ssh-public-key` with your Key Pair name that was automatically created in Lab 1 for the EC2 instance

2 . Copy the Key Pair name and then back in the CLoudShell, click the `up arrow keyboard button` to get the previous command.

4 . Adjust the `--ssh-public-key <YOUR-Key Pair-NAME>` argument and then run the command again.

* If you are at an AWS event using AWS Event Engine, then this value will be `ee-default-keypair`
* If you are using your own AWS Account, then copy the Key pair name you created earlier in the `Prerequisites` section and saved to your local notes.

If you still get an error, first check that you have the correct `--ssh-public-key` argument value.

### 💥 **TECHNICAL NOTE**

*Optionally, you can adjust the argument value for `--name dynatrace-workshop` if you are sharing an AWS account with others as to make it a unique cluster name.*

5 . Review the output will start to look like this and may take 20-30 minutes to fully provision.

```
cloudshell-user@ip-10-0-45-241 learner-scripts]$ eksctl create cluster --region us-west-2 --with-oidc --ssh-access --version=1.21 --managed --name dynatrace-workshop --tags "Purpose=dynatrace-modernization-workshop" --ssh-public-key jones-dynatrace-modernize-workshop
2021-09-03 19:26:32 [ℹ]  eksctl version 0.64.0
2021-09-03 19:26:32 [ℹ]  using region us-west-2
2021-09-03 19:26:32 [ℹ]  setting availability zones to [us-west-2a us-west-2b us-west-2d]
2021-09-03 19:26:32 [ℹ]  subnets for us-west-2a - public:192.168.0.0/19 private:192.168.96.0/19
2021-09-03 19:26:32 [ℹ]  subnets for us-west-2b - public:192.168.32.0/19 private:192.168.128.0/19
2021-09-03 19:26:32 [ℹ]  subnets for us-west-2d - public:192.168.64.0/19 private:192.168.160.0/19
2021-09-03 19:26:32 [ℹ]  nodegroup "ng-eaa2eae4" will use "" [AmazonLinux2/1.21]
2021-09-03 19:26:32 [ℹ]  using EC2 key pair %!q(*string=<nil>)
2021-09-03 19:26:32 [ℹ]  using Kubernetes version 1.21
2021-09-03 19:26:32 [ℹ]  creating EKS cluster "dynatrace-workshop" in "us-west-2" region with managed nodes
...
...
2021-09-03 19:28:33 [ℹ]  waiting for CloudFormation stack "eksctl-dynatrace-workshop-cluster"
2021-09-03 19:29:33 [ℹ]  waiting for CloudFormation stack "eksctl-dynatrace-workshop-cluster"
```

6 . When this command completes, you should see output such as:

```
2021-09-03 19:51:34 [ℹ]  node "ip-192-168-89-237.us-west-2.compute.internal" is ready
2021-09-03 19:53:35 [ℹ]  kubectl command should work with "/home/cloudshell-user/.kube/config", try 'kubectl get nodes'
2021-09-03 19:53:35 [✔]  EKS cluster "dynatrace-workshop-cluster" in "us-west-2" region is ready
```

### 💥 **TECHNICAL NOTE**

*It is possible that your AWS cloud shell will time out before you see the `EKS cluster is ready` in the `eksctl` console output. It that occurs, that is OK.  Just refresh your Cloud Shell connection to get back to the command prompt and just monitor the CloudFormation script progress from the AWS console as described next.*

### Verify Cluster Creation

To verify completion status of the CloudFormation script within the AWS console.

You can navigate to the CloudFormation page as shown below.
![image](img/setup-cloudformation-search.png)

Or use this link as shortcut to the CloudFormation page

* <a href="https://console.aws.amazon.com/cloudformation/home" target="_blank">https://console.aws.amazon.com/cloudformation/home</a>

On the CloudFormation page, click on the stack shown in this example below.

![image](img/setup-cloudformation-stacks.png)

Then click on `Events` to see the provisioning steps. As it processes, the statuses will start to show `CREATE_COMPLETE`

![image](img/setup-cloudformation-stacks-details.png)

You can monitor this as it runs for about 30 minutes. When it's complete, all statuses will show `CREATE_COMPLETE` 

## Verify Cluster

Only proceed with this next step once the CloudFormation stack shows `CREATE_COMPLETE` status.

![image](img/setup-stack-complete.png)

### 1. Verify Cluster within AWS Console

With the AWS Console, search for the `Elastic Kubernetes Service` or click on the link below.

* <a href="https://console.aws.amazon.com/eks/home#/clusters" target="_blank">https://console.aws.amazon.com/eks/home#/clusters</a>

![image](img/setup-eks-cluster.png)

The cluster page, click on the new workshop cluster. You should see a few nodes as shown below.

![image](img/setup-eks-cluster-detail.png)

Explore the configuration and view nodes details.

### 2. Verify Cluster using kubectl

Using the CloudShell, you can verify the new cluster with the <a href="https://kubernetes.io/docs/reference/kubectl/overview/" target="_blank">kubectl</a> command line tool used to control Kubernetes clusters. 
content/99_cleanup/index.md

1. Run this command to display the command line options

    ```
    kubectl
    ```

1. Run this command to configure `kubectl` to connect to the cluster

    ```
    aws eks update-kubeconfig --name $(aws eks list-clusters | jq -r .clusters[0])
    ```

1. Verify you are connected. You should see `dynatrace-workshop` as part of the output.

    ```
    kubectl config current-context
    ```

    The output should look something like this:

    ```
    [user-info]@dynatrace-workshop.us-west-2.eksctl.io
    ```

1. List the nodes in the cluster

    ```
    kubectl get nodes
    ```

    The output should look like this:

    ```
    NAME                                           STATUS   ROLES    AGE     VERSION
    ip-192-168-31-207.us-west-2.compute.internal   Ready    <none>   5d23h   v1.21.2-eks-c1718fb
    ip-192-168-86-194.us-west-2.compute.internal   Ready    <none>   5d23h   v1.21.2-eks-c1718fb
    ```

    You can see even more detail with this command.

    ```
    kubectl describe nodes
    ```
## Dynatrace Operator

One key Dynatrace advantage is ease of activation. OneAgent technology simplifies deployment across large enterprises and relieves engineers of the burden of instrumenting their applications by hand. As Kubernetes adoption continues to grow, it becomes more important than ever to simplify the activation of observability across workloads without sacrificing the deployment automation that Kubernetes provides. Observability should be as cloud-native as Kubernetes itself.

In our workshop, we will install the Dynatrace Operator that streamlines lifecycle management.  You can read more about it here in this <a href="https://www.dynatrace.com/news/blog/new-dynatrace-operator-elevates-cloud-native-observability-for-kubernetes/" target="_blank">Dynatrace blog</a>.

Organizations will often customize the Dynatrace Operator installation and you can read more about the options in the <a href="https://www.dynatrace.com/support/help/technology-support/container-platforms/kubernetes/monitor-kubernetes-environments/" target="_blank">Dynatrace docs</a> but, we are going to use a single command that we can get from the Dynatrace interface to show how easy it is to get started.

### Install Dynatrace Operator

1. To navigate to Kubernetes page, follow these steps and refer to the picture below:

    1. Within Dynatrace, click on the `Deploy Dynatrace` menu
    1. Click on the `Start Installation` button
    1. Click on the `Kubernetes` button

    ![image](img/lab4-operator-menu.png)

1. To get the Dynatrace Operator installation command, refer to the steps and pictures below:

    1. On the Kubernetes configuration page, enter `dynatrace-workshop` for the name. This is not the cluster name, it will show up as the Kubernetes page name in Dynatrace
    1. Click the `Create tokens` button
    1. Select the `Skip SSL Certificate Check` to be ON
    1. Click the `Copy` button

    ![image](img/lab4-operator.png)

1. Paste the command in SSH Shell and run it.  When you run the command, it will do the following:
    * Create a namespace called `dynatrace` in your cluster containing the Dynatrace Operator supporting pods
    * Set the OneAgent on each of the cluster nodes as to provide full-stack Dynatrace monitoring
    * Create a Kubernetes dashboard that will be populated with the Kubernetes data pulled from the API
    * Setup a Dynatrace Active gate that runs as a container in the `dynatrace` namespace that is used in the polling of Kubernetes API
    * Enable preset out-of-the-box Kubernetes dashboards

### Verify Dynatrace Operator

Once the script is complete, then monitor the installation until you all pods are in `Running` state with all pods as `1/1`.

```
kubectl -n dynatrace get pods
```

Rerun the command until the output looks like this:

```
NAME                                 READY   STATUS    RESTARTS   AGE
dynakube-classic-g5n9d               1/1     Running   0          2m45s
dynakube-classic-vr5qh               1/1     Running   0          2m45s
dynakube-kubemon-0                   1/1     Running   0          2m43s
dynakube-routing-0                   1/1     Running   0          2m45s
dynatrace-operator-f946fb4c6-q5k5g   1/1     Running   0          3m59s
```

### Verify Dynatrace Monitoring

We will review more detail shortly, but quickly verify within Dynatrace that the hosts are now monitored.

From the left-side menu in Dynatrace choose `Hosts`. Ensure the `management zone` filter is set to all `ALL`

![image](img/mz-pick-all.png)

You should see the two hosts like the ones shown below in addition to the host with the name `dt-orders-monolith`.

![image](img/lab2-eks-hosts.png)

## Deploy sample application

Dynatrace automatically derives tags from your Kubernetes/OpenShift labels. This enables you to automatically organize and filter all your monitored Kubernetes/OpenShift application components.

To review what is configured for the sample application, go ahead and open this folder and look at one such as the `frontend.yml`:

* <a href="https://github.com/dt-alliances-workshops/aws-modernization-dt-orders-setup/tree/main/app-scripts/manifests" target="_blank">https://github.com/dt-alliances-workshops/aws-modernization-dt-orders-setup/tree/main/app-scripts/manifests</a>

Notice the labels and annotations:

```
metadata:
      labels:
        app.kubernetes.io/name: frontend
        app.kubernetes.io/version: "1"
        app.kubernetes.io/component: frontend
        app.kubernetes.io/part-of: dt-orders
        app.kubernetes.io/managed-by: helm
        app.kubernetes.io/created-by: dynatrace-demos
      annotations:
        owner: Team Frontend
        chat-channel: dev-team-frontend 
```

Notice the defined container and version.  These containers are stored in <a href="https://hub.docker.com/u/dtdemos" target="_blank">Dockerhub</a>.

```
spec:
    containers:
    - name: frontend
    image: dtdemos/dt-orders-frontend:1
```

Notice the `DT_CUSTOM_PROPS` environment variable:

```
env:
    - name: DT_CUSTOM_PROP
        value: "project=dt-orders service=frontend"
```

### 💥 **TECHNICAL NOTES** 

* The `DT_CUSTOM_PROPS` is a special Dynatrace feature, that the OneAgent will automatically recognize and make Dynatrace tags for the process. You can read more details in the <a href="https://www.dynatrace.com/support/help/shortlink/process-group-properties#anchor_variables" target="_blank">Dynatrace documentation</a>


* Read more details on how Dynatrace identifies labels and tags Kubernetes in the <a href="https://www.dynatrace.com/support/help/technology-support/container-platforms/kubernetes/other-deployments-and-configurations/leverage-tags-defined-in-kubernetes-deployments" target="_blank">Dynatrace documentation</a>

### Run the script to deploy the sample application

Back in the SSH shell, run these commands to deploy the application:

```
cd ~/aws-modernization-dt-orders-setup/app-scripts
./start-k8.sh
```

### 💥 **TECHNICAL NOTE**

The <a href="https://github.com/dt-alliances-workshops/aws-modernization-dt-orders-setup/tree/main/app-scripts" target="_blank">start-k8.sh</a> script automates a number of `kubectl` commands:

1. Create a namespace called `staging` where all these resources will reside
1. Grant the Kubernetes default service account a viewer role into the `staging` namespace
1. Create both the `deployment` and `service` Kubernetes objects for each of the sample

### Verify the pods are starting up

Rerun this command until all the pods are in `Running` status with all pods as `1/1`.

```
kubectl -n staging get pods
```

The output should look like this:

```
NAME                               READY   STATUS    RESTARTS   AGE
browser-traffic-5b9456875d-ks9vw   1/1     Running   0          30h
catalog-7dcf64cc99-hfrpg           1/1     Running   0          2d8h
customer-8464884799-vljdx          1/1     Running   0          2d8h
frontend-7c466b9d69-9ql2g          1/1     Running   0          2d8h
load-traffic-6886649ddf-76pqf      1/1     Running   0          2d8h
order-6d4cd477cb-9bvn4             1/1     Running   0          2d8h
```

### Kubernetes Role Binding - Overview

In Kubernetes, every pod is associated with a service account which is used to authenticate the pod's requests to the Kubernetes API. If not otherwise specified the pod uses the default service account of its namespace.

* Every namespace has its own set of service accounts and thus also its own namespace-scoped default service account. The labels of each pod for which the service account has view permissions will be imported into Dynatrace automatically.

* In order for Dynatrace to read the Kubernetes properties and annotations, you need to grant the Kubernetes default service account a viewer role into the `staging` namespace to enable this. We only have one namespace, but you will need to repeat these steps for all service accounts and namespaces you want to enable for Dynatrace within your environments.

For the workshop, we already updated the required file with the `staging` namespace. Next you will run the setup script that will apply it to your cluster. Go ahead and open this folder and look at the `dynatrace-oneagent-metadata-viewer.yaml` file. 
* <a href="https://github.com/dt-alliances-workshops/aws-modernization-dt-orders-setup/tree/main/app-scripts/manifests" target="_blank">https://github.com/dt-alliances-workshops/aws-modernization-dt-orders-setup/tree/main/app-scripts/manifests</a>

### Review Kubernetes within Dynatrace

Now lets verify what happened within Dynatrace.

1. From the Dynatrace Menu, click `Manage --> Deployment status` to review OneAgent Deployment status

1. Within the `Deployment status` page, next click on the `ActiveGate` option to review the Active Gate. 

### Review Kubernetes Architecture 

From the left-side menu in Dynatrace choose `Kubernetes` and navigate to the Kubernetes cluster page as shown below:

**NOTE: Be sure that your management zone is NOT filtered!**

![image](img/lab2-k8s-layers.png)

**1 - Kubernetes cluster**

A summary the Kubernetes cluster is shown at the top of the Kubernetes dashboard.

**2 - Nodes**

The resources for the Cluster are summarized for the one-to-many hosts or Cluster nodes in this view.
Explore specific node in the Node Analysis section, pick the analyze nodes button.
![image](img/lab4-eks-nodeutil.png)

**3 - Namespaces**

Note: Namespaces are ways to partition your cluster resources to run multiple workloads (for example `application A` and `application B` workloads) on same cluster
1.	This workload section shows workloads over time
2.	In the Cluster workload section, pick the view all workloads button.

![image](img/lab4-eks-workload.png)
  
In the filter, pick namespace then staging

![image](img/lab4-eks-workload-filter.png)

**4 - Kubernetes workload**

Pick the `frontend` to drill into.

![image](img/lab4-eks-kubeworkload.png)

Review the workload overview page to look at various metrics related to the workload.

Click on Kubernetes POD to look at POD utilization metrics.

![image](img/lab4-eks-frontend-workload.png)

**5 - POD**

Review the POD overview page to look at various metrics related to the POD
Click on Container next to look at container metrics
 
![image](img/lab4-eks-pod.png)

**6 - Containers** 

Referring to the diagram above, expand the properties and tags section to view:
1. Container information
2. Kubernetes information
3. In the info graphic, pick the service to open the services list
4. In the service list, click on k8-frontend service

![image](img/lab4-eks-container.png)

Next click on 2 Services Icon to review the services running inside the container
Select the active front-end service.
 
**7 - Service**

This view should now look familiar. In Lab 1, we looked at the service for the frontend and backend.  Notice how the Kubernetes information is also available in the service properties.  

![image](img/lab4-eks-service.png)

## Sample application Kubernetes details

Refer to this picture for a more detailed description of our setup. 

![image](img/lab2-k8s-namespaces.png)

**1 - Dynatrace Namespace**

This <a href="https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/" target="_blank">Kubernetes Namespace</a> contains the pods and services that make up the Dynatrace Operator.

**2 - Kubernetes nodes**

Kubernetes runs your workload by placing containers into Pods to run on <a href="https://kubernetes.io/docs/concepts/architecture/nodes/" target="_blank">Nodes</a>.

**3 - Dynatrace**

Dynatrace tenant where monitoring data is collected and analyzed.

**4 - Cloud shell**

The shell is configured with the <a href="https://kubernetes.io/docs/reference/kubectl/overview/" target="_blank">kubectl</a> command line tool that lets you control Kubernetes clusters.

**5 - Sample application namespace**

This <a href="https://kubernetes.io/docs/concepts/overview/working-with-objects/namespaces/" target="_blank">Kubernetes Namespace</a> contains the sample application pods and services.

**6 - Sample application**

The frontend service is exposed as a public IP and is accessible in a browser.

## Review sample app in a browser

To view the application, we need to get the IP to the Kubernetes service for the sample application. To do this, we need to run a kubernetes command.

From the SSH CLI SSH command prompt type this command

```
kubectl -n staging get svc
```

Example output

```
NAME       TYPE           CLUSTER-IP       EXTERNAL-IP
catalog    ClusterIP      10.100.181.171   <none>                                                                  
customer   ClusterIP      10.100.147.216   <none>
frontend   LoadBalancer   10.100.58.2      a6ebaa4a370e0468093167462c3aeab2-115097342.us-west-2.elb.amazonaws.com
order      ClusterIP      10.100.228.17    <none>
```

From the output, copy the entire value from EXTERNAL-IP and open it in a browser. This would be `http://1a6ebaa4a370e0468093167462c3aeab2-115097342.us-west-2.elb.amazonaws.com` for the example above. 

## Explore Sample app

Use the menu on on the home page to navigate around the application and notice the URL for key functionality. You will see these URLs later as we analyze the application.

 * Customer List = customer/list.html
 * Customer Detail = customer/5.html
 * Catalog List = catalog/list.html
 * Catalog Search Form = catalog/searchForm.html
 * Order List = order/list.html
 * Order Form = order/form.html

### 💥 **TECHNICAL NOTE** 

The application looks like this monolith, but notice how the home page shows the versions of the three running backend services. You will see these version updated automatically as we deploy new versions of the backend services.

## Backtrace

### Open Service Page

First filter by ``` dt-orders-k8 management ``` zone.

![image](img/lab4-k8-mgmtzone-filter.png)

Pick the ``` order ``` service.

![image](img/lab4-k8-service-filter.png)

On this service, we can quickly review the inbound and outbound dependencies.

Referring to the picture, within the services infographic, click on the "services" square to get a list of the services that the order service calls.

![image](img/lab4-k8-service-view.png)

### Open Backtrace Page

To see the backtrace page, just click on the Analyze Backtrace button.

You should be on the service backtrace page where you will see information for this specific service.

This will get more interesting in the next lab, but for the monolith backend, we can see that the backtrace is as follows:

1 . The starting point is the backend

2 . Backend service is called by the front-end

3 . Front-end is a where end user requests start and the user sessions get captured 

4 . My web application is the default application that Dynatrace creates

![image](img/lab4-k8-service-backflow.png)

### 👍 How this helps

The service flow and service backtrace give you a complete picture of interdependency to the rest of the environment architecture at host, processes, services, and application perspectives.

## Serviceflow

### Analyze the Service Flow 
Now that we are back on the frontend service, let's look at the service flow to see what's different now. Just click on the view service flow button to open this.

![image](img/lab4-serviceflow.png) 

### Response time perspective

You should now be on the Service flow page.

Right away, we can see how this application is structured:
* Frontend calls order, customer, and catalog service
* Order service calls order and customer service

Something you would never know from the application web UI!

![image](img/lab4-serviceflow-responsetime.png)

Refer to the picture above:
1.	We are viewing the data from a Response time perspective. Shortly, we will review the Throughput perspective.
2.	Click on the boxes to expand the response time metrics. Most of the response time is spent in the order service and the least in the customer services. And as in the simple version of the application, a very small amount of the response time is spent in the databases.

### Throughput perspective

![image](img/lab4-serviceflow-thoroughput.png)   

Refer to the picture above:
1.	Change to the Throughput perspective by clicking on the box
2.	Click on the boxes to expand the metrics to see the number of requests and average response times going to each service

### 👍 How this helps

Reviewing the architecture before and after changes is now as easy as a few clicks!

## Summary

While migrating to the cloud, you want to evaluate if your migration goes according to the plan, whether the services are still performing well or even better than before, and whether your new architecture is as efficient as the blueprint suggested. Dynatrace helps you validate all these steps automatically, which helps speed up the migration and validation process.

Having the ability to understand service flows enables us to make smarter re-architecture and re-platforming decisions.  With support for new technologies like Kubernetes, you have confidence to modernize with a platform that spans the old and the new. 

Over time, you can imagine that this sample application will be further changed to add in other technologies like [AWS Lambda](https://aws.amazon.com/lambda/) and other PaaS services like [AWS Relational Database Service (RDS)](https://aws.amazon.com/rds/) or [Amazon Aurora - MySQL and PostgreSQL-compatible relational database](https://aws.amazon.com/rds/aurora) databases and virtual networking [Amazon API Gateway](https://aws.amazon.com/api-gateway/) as shown in the picture below. 

![image](img/lab2-picture-future.png)

### 💥 **TECHNICAL NOTE**

_We will not cover this, but organizations are establishing DevOps approaches and establishing Continuous Integration (CI) pipelines to build and test each service independently. Then adding Continuous Deployment (CD) to the process too that vastly increase our ability to delivery features faster to our customers.  Dynatrace has a number of solutions to support DevOps that you can read about [here](https://www.dynatrace.com/solutions/devops/)_

### 💥 **TECHNICAL NOTE**

_Dynatrace sees a lot of demand for Lambda serverless compute service and a slew of new capabilities that you can read about in these [Dynatrace blogs](https://www.dynatrace.com/news/tag/aws-lambda/)_

### Checklist

In this section, you should have completed the following:

✅ Install the Dynatrace Operator and sample application

✅ Review how the sample application went from a simple architecture to multiple services 

✅ Examine the transformed application using service flows and backtraces 
