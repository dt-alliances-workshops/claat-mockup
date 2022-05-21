summary: Lab 6 Dynatrace Workshop on Azure
id: azure-lab6
categories: modernization,kubernetes,all
tags: azure
status: Published
authors: Jay Gurbani
Feedback Link: mailto:jay.gurbani@dynatrace.com

# Azure Workshop Lab 6 - Reminder & Cleanup

## Workshop Environment Reminder

If you plan to keep the workshop resources running in Azure for a few more days to come back and review the labs, please keep in mind the following things:

* Your free Azure Subscription credits will expire after 5 days or until the $100 credit is utilized by Azure Resources **(whichever comes first)**
    <aside class="positive"> 💡 To check how much credits are still left over on your Azure subscription, please go to site [Azure Sponsorship](https://www.microsoftazuresponsorships.com/Balance) </aside>
* Your Dynatrace Environment will disabled after 7 calendar days of your workshop.

## Workshop Cleanup

When you are ready to cleanup the workshop resource, run this command to remove the Azure resources and Dynatrace configuration:

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

### Free Dynatrace SaaS tenant 
To signup for a free fully featured enabled Dynatrace SaaS Tenant for 15 days [click here](https://www.dynatrace.com/trial/) 

### Resources
Addition Azure & Dynatrace related resources to get your started with:

* [Partner Cafe Quick Azure Overview](https://www.youtube.com/watch?v=VCdEHAoEePw)
* [Dynatrace YouTube Videos](https://www.youtube.com/channel/UCcYJ-5q_AfmjQ4XTjTS0o3g)
* [More Support resources](https://www.dynatrace.com/services-support/#support-resources-section)
* Customer Stories:​
    - [Barbari](https://www.dynatrace.com/news/customer-stories/barbri/)
    - [Kroger](https://www.dynatrace.com/news/customer-stories/kroger/)
    - [Mitchells & Butlers](https://www.dynatrace.com/news/customer-stories/mitchells-and-butlers/)
