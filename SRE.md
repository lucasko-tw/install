


### 
 1. 22% of organizations in a survey of 2,000 respondents had adopted the SRE model. ( Airbnb, Dropbox, IBM,[9] LinkedIn, Netflix,[7] and Wikimedia.)

 2. Developers had to dedicate at least 5% of their work time to performing Ops responsibilities (answering on-call requests, dealing with tickets, monitoring service

### Concept
Service Level: Indicators (SLIs) are one or more quantifiable reliability measures of the software solution from the perspective of your customers. In a web solution, good examples would be the HTTP status codes (2xx, 5xx, etc) and the overall end-to-end latency.

Service Level: Objectives (SLOs) are one or more targets for a specific SLI over a fixed period of time. In a web solution, that could be aiming for a maximum of 1% HTTP 5xx (server error) per month or achieving a under 200ms latency in every http request per day.

Reliability: is a value that can be obtained by simply dividing the number of successful actions (how many times it worked well) by the total number of actions.

Error budget: refers to the amount of unreliability that the stakeholders are willing to tolerate. In essence, it can be obtained by subtracting the reliability value from 100%.


### Technical benefits of DevOps + Case Study

https://www.simform.com/blog/benefits-of-devops/

1. Rabobank: 
 > 12X speedy recovery in case of downtime due to errors
 > 60% faster deployments

1. TransTMS:    
 > 33% of savings on the operational costs
 > Reduced time spent on customers by 40% 

Nordstrom:
 > Reduction in delivery time from 3 months to 30 minutes
 > Rapid deployments across environments

DoD:
 > Total development time reduced from weeks or days to minimal hours for 22 areas

### SRE Tasks and Responsibilities
1.Automation - Create automated processes for operational aspects 
2.Configure Monitoring and Logging (Observability for System Performance)
3.Error/Issue Detection
4.Alert.  alert message should contain all the needed information to identify and fix the issue fast.
5.Post-Incident Reviews 

```
Instead of:
❌ "something is wrong in the cluster"
a more detailed message like:
✅ "service a in cluster b is throwing 500 error"
```

###
1. SRE accomplishes customer expectations on the functionality and valuable life of Performance Monitoring Tools.
2. Exposure to systems in staging and production, both along with all technical teams.
3. SRE lessens the foreseeable risks inherent to the performance of the tools and the health hazards.
4. SRE increases the Reliability and Availability of the systems by reducing the failure rates and downtime.
5. It prevents failures, avoid recurrences, and recover quickly and reset a failing system to reboot.
6. SRE helps to achieve production goals quickly and more efficiently.

### The Four Golden Signals
1. Latency: the time it takes to serve a request. ( a slow error is even worse than a fast error! )
2. Traffic: the total number of requests across the network. ( HTTP requests per second)
3. Errors: the number of requests that fail.
4. Saturation: the load on your network and servers. (Memory/IO)

For services-related monitoring consider the RED Method.
Rate (the number of requests per second)
Errors (the number of those requests that are failing)
Duration (the amount of time those requests take)


### Benefits
1. implement changes gradually to reduce the overall cost of failure
2. SRE mindset, teams start to accept operational failures as normal and learn from their own mistakes and incidents in a blameless manner.