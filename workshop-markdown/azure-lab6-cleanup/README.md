summary: Dynatrace Workshop on Azure - lab6
id: azure-lab6
categories: modernization,kubernetes
tags: azure
status: Published
authors: Jay Gurbani
Feedback Link: https://github.com/dt-alliances-workshops/workshops-content

# Azure Workshop Lab 6 - Cleanup

## Workshop Cleanup

If you plan to keep things running so you can examine the workshop a bit more please remember to do the cleanup when you are done. So, when you are ready, run this command to remove the Azure resources and Dynatrace configuration:

```
cd ~/azure-modernization-dt-orders-setup/provision-scripts
./cleanup-workshop.sh
```

The start of the script output will look like this:

```
===================================================================
About to Delete Workshop resources
===================================================================
Proceed? (y/n) : y

==========================================
Deleting workshop resources
Starting: Fri 07 May 2021 04:35:46 AM UTC
==========================================
...
...
```

Eventually when it completes - plan for 5-10 minutes - it will look like this:

```
=============================================
Deleting workshop resources COMPLETE
End: Fri 07 May 2021 04:40:40 AM UTC
=============================================
```

## Use Dynatrace to try some of your applications

You have a fully feature enabled 15 day Dynatrace trial, so keep using it to monitor and manage your infrastructure and applications!!

Here are resources to get your started:

* [Learn more about your tenant and install more OneAgents](https://www.dynatrace.com/support/help/get-started/get-started-with-dynatrace-saas/)
* [Add other users to your tenant](https://www.dynatrace.com/support/help/how-to-use-dynatrace/user-management-and-sso/manage-groups-and-permissions/)
* [YouTube Videos](https://www.youtube.com/channel/UCcYJ-5q_AfmjQ4XTjTS0o3g)
* [More Support resources](https://www.dynatrace.com/services-support/#support-resources-section)