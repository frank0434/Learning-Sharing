---
title: Telegraf-influxDB-Grafana stack for IoT stuff in docker
author: Frank
date: '2020-11-10'
slug: telegraf-influxdb-grafana-stack-for-iot-stuff
categories:
  - IoT
tags:
  - tricks
emoji: yes
output:
  blogdown::html_page:
    toc: yes
---


**TL;TR**  

Explore the platform - [Telegraf](https://www.influxdata.com/time-series-platform/telegraf/), [InfluxDB](https://www.influxdata.com/products/influxdb-overview/) and [Grafana](https://grafana.com/) (TIG).   

- Advantages:  
i.  True IoT setup. Data ingestion happens in millisenconds via telegraf. Telegraf can be added as a windowns service, which means restart computer won't destroy the workflow.     
ii. Time series database, super efficient.   
iii. Full interactive dashboard with drag and drop buidling mechnism. 
- Disadvantages:  
i.  Telegraf configuration.   
ii. InfluxDB query lanuage.   

# Docker-compose files for a simple uptodate
# InfluxDB
# + Grafana stack
# + Telegraf

Get the stack (only once):

```
git clone https://github.com/nicolargo/docker-influxdb-grafana.git
cd docker-influxdb-grafana
docker pull grafana/grafana
docker pull influxdb
docker pull telegraf
```
Better use a download version [telegraf](https://www.influxdata.com/time-series-platform/telegraf/) since the docker image for telegraf will casuse headache to configure correctly for monitoring files or systems outside of the docker container. 

Modify the compose file to work on machines without admin access. 
[Reference post](https://towardsdatascience.com/get-system-metrics-for-5-min-with-docker-telegraf-influxdb-and-grafana-97cfd957f0ac)

The post has a quick walkthrough example to deploy influxdb and grafana.
The git repo has all three deploy together, but have to confige the telegraf. 

Current demo combined both.

The compose file from the git repo was modified to a version:"2" with services that includes all 3 stacks, a network and external volumes. 

External volume and resources have to be created manually. 
```
docker network create monitoring
docker volume create grafana-volume
docker volume create influxdb-volume
```
Additional docker run commond from the post was used to inital an influxdb.

```
docker run --rm \
  -e INFLUXDB_DB=telegraf -e INFLUXDB_ADMIN_ENABLED=true \
  -e INFLUXDB_ADMIN_USER=admin \
  -e INFLUXDB_ADMIN_PASSWORD=supersecretpassword \
  -e INFLUXDB_USER=telegraf -e INFLUXDB_USER_PASSWORD=secretpassword \
  -v influxdb-volume:/var/lib/influxdb \
  influxdb /init-influxdb.sh
```

Telegraf was configured by the recipe from the post. 

Main changes are in the output plugins area:  
1. urls to access influxdb was changed to host:port  
2. username and password  


[Demo](http://aklpps14:3001/d/Wleg9d2Mz/telegraf-system-overview?orgId=1&refresh=1m)

Tips:

Anonymous dashboard viewing could be configured with a env file. 
Here used a file called `env.grafana`. 
The oragnisation name need to be the same in the `Configuration->Pereference` and the one in the env file. 

Show me the logs:

```
docker-compose logs
```

Stop it:

```
docker-compose stop
docker-compose rm
```

Update it:

```
git pull
docker pull grafana/grafana
docker pull influxdb
docker pull telegraf
```

If you want to run Telegraf, edit the telegraf.conf to yours needs and:

```
docker exec telegraf telegraf
```
