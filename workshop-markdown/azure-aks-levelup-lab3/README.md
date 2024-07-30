summary: Dynatrace Workshop on Azure AKS Levelup - Lab3
id: azure-aks-levelup-lab3
categories: aks, all
tags: aks
status: Published
authors: Jay Gurbani
Feedback Link: mailto:jay.gurbani@dynatrace.com

# Azure Workshop Lab 3 - Reminder & Cleanup

## Workshop Environment Reminder

If you plan to keep the workshop resources running in Azure for a few more days to come back and review the labs, please keep in mind the following things:

* Your Dynatrace Environment will disabled after 30 calendar days of your workshop.

## Workshop Cleanup

When you are ready to cleanup the workshop Azure resource, run this command to remove the Azure resources and Dynatrace configuration:

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

## Other Resources

Addition Azure & Dynatrace related resources to get your started with:

* [Partner Cafe Quick Azure Overview](https://www.youtube.com/watch?v=VCdEHAoEePw)
* [Dynatrace YouTube Videos](https://www.youtube.com/channel/UCcYJ-5q_AfmjQ4XTjTS0o3g)
* [Dynatrace Platform docs](https://docs.dynatrace.com/docs/platform)
* [Dynatrace Azure Integrations Docs](https://docs.dynatrace.com/docs/setup-and-configuration/setup-on-cloud-platforms/microsoft-azure-services/azure-integrations)
* [Azure Native Dynatrace Service Docs](https://docs.dynatrace.com/docs/setup-and-configuration/setup-on-cloud-platforms/microsoft-azure-services/azure-platform/azure-native-integration)
* [Azure Monitor Metrics](https://docs.dynatrace.com/docs/setup-and-configuration/setup-on-cloud-platforms/microsoft-azure-services/azure-integrations/azure-cloud-services-metrics)
* Customer Stories:​
    - [OneStream](https://www.dynatrace.com/customers/onestream/)
    - [Kroger](https://www.dynatrace.com/news/customer-stories/kroger/)
    - [TD Bank](https://www.dynatrace.com/customers/td-bank/)
    - [Park 'N Fly](https://www.dynatrace.com/customers/park-n-fly/)
