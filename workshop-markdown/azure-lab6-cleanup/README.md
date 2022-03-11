summary: Dynatrace Workshop on Azure - lab6
id: azure-lab6
categories: modernization, kubernetes
tags: azure
status: Published
authors: Jay Gurbani
Feedback Link: mailto:jay.gurbani@dynatrace.com

# Azure Workshop Lab 6 - Reminder & Cleanup

## Workshop Environment Reminder

If you plan to keep the Workshop resources running for a few days to come back and review the labs, please keep in mind the following items:

* Free Azure Subscription credits will expire after 5 days or until when the $100 credit is utilized by Azure Resources (whichever comes first)
* Dynatrae Managed Environment will disabled after 7 calendars of your workshop.

## Workshop Cleanup

When you are ready cleanup the workshop resource, run this command to remove the Azure resources and Dynatrace configuration:

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
To signup for a free fully feature enabled Dynatrace SaaS Tenant for 15 days [click here](https://www.dynatrace.com/trial/) 

### Resources
Addition Azure & Dynatrace related to get your started:

* [Partner Cafe Quick Azure Overview](https://www.youtube.com/watch?v=VCdEHAoEePw)
* [Dynatrace YouTube Videos](https://www.youtube.com/channel/UCcYJ-5q_AfmjQ4XTjTS0o3g)
* [More Support resources](https://www.dynatrace.com/services-support/#support-resources-section)
* Customer Stories:​
    - [Barbari](https://www.dynatrace.com/news/customer-stories/barbri/)
    - [Kroger](https://www.dynatrace.com/news/customer-stories/kroger/)
    - [Mitchells & Butlers](https://www.dynatrace.com/news/customer-stories/mitchells-and-butlers/)

## Feedback
Duration: 3

We hope you enjoyed this lab and found it useful. We would love your feedback!
<form>
  <name>How was your overall experience with this lab?</name>
  <input value="Excellent" />
  <input value="Good" />
  <input value="Average" />
  <input value="Fair" />
  <input value="Poor" />
</form>

<form>
  <name>What did you benefit most from this lab?</name>
  <input value="Understanding Azure Monitoring setup with Dynatrace" />
  <input value="Learning about Azure" />
  <input value="Learning about Application Modernization" />
  <input value="Learning about Kubernetes" />
</form>

<form>
  <name>How likely are you to recommend this workshop to a friend or colleague?</name>
  <input value="Very Likely" />
  <input value="Moderately Likely" />
  <input value="Neither Likely nor unlikely" />
  <input value="Moderately Unlikely" />
  <input value="Very Unlikely" />
</form>

Positive
: 💡 For other ideas and suggestions, please [reach out via email](mailto:jay.gurbani@dynatrace.com?subject="Azure Workshop Feedback").