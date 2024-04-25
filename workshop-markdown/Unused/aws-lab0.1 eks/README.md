id: aws-lab0-eks
categories: kubernetes
tags: 
status: Hidden

# AWS Lab 0 - Provisions EKS Cluster

## Overview

Since the Kubernetes may take awhile, follow these steps for that task then once complete move to the overview and exercises in the `Lab 6 - Dynatrace Operator for Kubernetes`

### 💥💥💥 Notice 💥💥💥

Only follow these instructions if you are running Modernization with Kubernetes Lab.

## Install Kubernetes CLI utility

Kubernetes uses this command line utility for communicating with the cluster API server. You can find out more by checking out the documentation

 * <a href="https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html" target="_blank">https://docs.aws.amazon.com/eks/latest/userguide/install-kubectl.html</a>

1 . From the AWS Cloudshell, create a new folder in your home directory

```
mkdir -p $HOME/bin 
```

2 . Install `kubectl`. 

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

## Install eksctl utility

The [eksctl](https://eksctl.io/) command line utility provides the fastest and easiest way to create a new cluster with nodes for Amazon EKS. 

1 . Download binary

```
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
```

2 . Move the extracted binary to /usr/local/bin.

```
sudo mv /tmp/eksctl /usr/local/bin
```

3 . Test that your installation was successful with the following command. The version should be at least 0.138.0.

```
eksctl version
```

## Create Cluster

If you are at an AWS event and using an AWS event engine code, your cluster may have been automatically created in advance and you can skip this page and proceed to the `Verify Cluster` page.

If you are at not at an AWS event or you do not have a cluster, then follow these steps to setup you cluster.

### Using eksctl to create your cluster 

When you run the eksctl command below to create your cluster, it create a CloudFormation script for you.  This CloudFormation will the take 20-30 minutes to fully provision and you can monitor the status with the AWS console.

### 💥💥💥 If you are at an AWS Event follow this step 💥💥💥  

This assumes the AWS keypair with the name `ee-default-keypair` is created.

1 . Copy the `eksctl create cluster ...` command below into your Cloud Shell

```
eksctl create cluster --with-oidc --ssh-access --version=1.25 --managed --name dynatrace-workshop --tags "Purpose=dynatrace-modernization-workshop" --ssh-public-key ee-default-keypair
```

3 . Run the command

### 💥💥💥 If you are at NOT an AWS Event follow this step 💥💥💥  

You **MUST** replace the argument value for `--ssh-public-key` with your Key Pair name that was automatically created in Lab 1 for the EC2 instance

1 . Copy the `eksctl create cluster ...` command below into your Cloud Shell

```
eksctl create cluster --with-oidc --ssh-access --version=1.25 --managed --name dynatrace-workshop --tags "Purpose=dynatrace-modernization-workshop" --ssh-public-key <YOUR-KEY-PAIRNAME>
```

2 . Adjust the `--ssh-public-key <YOUR-Key Pair-NAME>` argument

3 . Run the command

## Review eksctl output

Review the output will start to look like this and may take 20-30 minutes to fully provision.

```
cloudshell-user@ip-10-0-45-241 learner-scripts]$ eksctl create cluster --region us-west-2 --with-oidc --ssh-access --version=1.23 --managed --name dynatrace-workshop --tags "Purpose=dynatrace-modernization-workshop" --ssh-public-key jones-dynatrace-modernize-workshop
2021-09-03 19:26:32 [ℹ]  eksctl version 0.64.0
2021-09-03 19:26:32 [ℹ]  using region us-west-2
2021-09-03 19:26:32 [ℹ]  setting availability zones to [us-west-2a us-west-2b us-west-2d]
2021-09-03 19:26:32 [ℹ]  subnets for us-west-2a - public:192.168.0.0/19 private:192.168.96.0/19
2021-09-03 19:26:32 [ℹ]  subnets for us-west-2b - public:192.168.32.0/19 private:192.168.128.0/19
2021-09-03 19:26:32 [ℹ]  subnets for us-west-2d - public:192.168.64.0/19 private:192.168.160.0/19
2021-09-03 19:26:32 [ℹ]  nodegroup "ng-eaa2eae4" will use "" [AmazonLinux2/1.21]
2021-09-03 19:26:32 [ℹ]  using EC2 key pair %!q(*string=<nil>)
2021-09-03 19:26:32 [ℹ]  using Kubernetes version 1.23
2021-09-03 19:26:32 [ℹ]  creating EKS cluster "dynatrace-workshop" in "us-west-2" region with managed nodes
...
...
2021-09-03 19:28:33 [ℹ]  waiting for CloudFormation stack "eksctl-dynatrace-workshop-cluster"
2021-09-03 19:29:33 [ℹ]  waiting for CloudFormation stack "eksctl-dynatrace-workshop-cluster"
```

When this command completes, you should see output such as:

```
2021-09-03 19:51:34 [ℹ]  node "ip-192-168-89-237.us-west-2.compute.internal" is ready
2021-09-03 19:53:35 [ℹ]  kubectl command should work with "/home/cloudshell-user/.kube/config", try 'kubectl get nodes'
2021-09-03 19:53:35 [✔]  EKS cluster "dynatrace-workshop-cluster" in "us-west-2" region is ready
```

### 💥 **TECHNICAL NOTE**

It is possible that your AWS cloud shell will time out before you see the `EKS cluster is ready` in the `eksctl` console output. It that occurs, that is OK.  Just refresh your Cloud Shell connection to get back to the command prompt and just monitor the CloudFormation script progress from the AWS console as described next.

## Next Steps

Once you have started the process to provision your Kubernetes cluster, you can move to the next labs that will have steps to verify the setup.
