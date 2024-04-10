summary: Dynatrace Workshop on Azure Grail Lab5
id: azure-grail-lab5
categories: grail,all
tags: azure
status: Published
authors: Jay Gurbani
Feedback Link: https://github.com/dt-alliances-workshops/workshops-content

# Azure Grail Workshop Lab 5 - SRE Guardian and Workflow

## Workflow Overview
A workflow in Dynatrace refers to a sequence of automated steps or tasks that can be triggered based on specific conditions or events within your monitored environment. These workflows are crucial in automating the response to particular situations and ensuring the smooth running of applications and systems.

### 1. Events or Conditions
Workflows are often triggered by certain events or conditions. These can range from the detection of specific performance issues, the breaching of a certain threshold, changes in the status of entities or services, and more.

### 2. Actions
Once a workflow is triggered, it performs a series of automated actions. These could be sending alerts or notifications, invoking remediation scripts, initiating a diagnostic process, or even triggering another workflow.

### 3. Customization
Workflows can be customized to meet the specific needs of an organization. They can be configured to trigger under certain conditions, and the actions they take can be tailored to the organization's requirements. This allows organizations to have more fine-grained control over their automated response processes.

### 4. Integration
Dynatrace workflows can be integrated with other tools and systems. This includes IT Service Management (ITSM) tools, DevOps tools, notification channels like Slack or email, and more. This allows the workflows to interact with other parts of the organization's infrastructure, enhancing their capability and utility.

### 5. Visualization
Dynatrace provides visualization features for workflows. This allows users to see the flow of the tasks in a visual form, making it easier to understand and manage.

### 6. Monitoring and Reporting
Workflows also include monitoring and reporting capabilities. This allows users to track the execution of workflows, assess their effectiveness, and make improvements where necessary.

Workflows in Dynatrace, therefore, are a powerful tool for automating the response to various events and conditions, ensuring that the right actions are taken quickly and efficiently.

## Getting started with Workflow

### Tasks to complete this step

1. Sign in to Dynatrace.
1. In the Dynatrace Launcher, select Workflows Workflows.
1. Select Add New workflow to create your first workflow. The Workflow editor opens.
1. Select the workflow title ("Untitled Workflow") and customize the name e.g. "Hello World".
1. In the Choose trigger section, select the On demand trigger. This means you can run the workflow via web UI or API. The web UI shows you an example API request.
1. To add the first task, select Add on the trigger node of the workflow graph.
1. In the Choose action section, which lists all available actions for tasks, select "Submit result". The workflow now has its first task and shows the input configuration for that task on the right.
    - For the Exercise name, enter "1"
    - For the result, enter "Hello from Denver"
1. Select Run to execute the workflow.
1. The first time you run a workflow, you're prompted to authorize the automation service to run a workflow as your user. Select Allow and run if you agree with that. You can always restrain the configuration in the settings.

## Workflow Use Case for Reporting

Let's say you manage an e-commerce platform. Your team has recently deployed several updates to enhance user experience. To ensure these changes are working as expected and have not introduced any new performance issues, you need a robust observability strategy - so you decided to use Dynatrace.

Since your demand on your services is very elastic, various services spin up and down every day. However, at the end of the day your boss wants to know how many GCP instances were running that day, what the name of those is and how long they were running - so you created a DQL query for that that you now have to run at 6:00 pm every day - which means that after picking up your daughter from school, you again have to log in to execute this DQL query:

### Tasks to complete this step

1. DQL Query
    ```
        fetch dt.entity.host, from:now() - 24h
        | filter cloudType == "AZURE"
        | fields Host = entity.name, started = arrayMax(array(now() - 24h, lifetime[start])), ended = arrayMin(array(now(), lifetime[end]))
        | fields Host, Runtime = toString(ended - started)
        | sort Runtime desc
    ```

## Getting started with SRE Guardian

### Tasks to complete this step

1. 
1. 