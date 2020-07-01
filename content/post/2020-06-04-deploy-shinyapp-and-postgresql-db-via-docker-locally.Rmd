---
title: Deploy shinyapp and postgreSQL db via docker locally
author: Frank
date: '2020-06-04'
slug: deploy-shinyapp-and-postgresql-db-via-docker-locally
categories: []
tags:
  - tricks
emoji: yes
output:
  blogdown::html_page:
    toc: yes
---

The easiest way is probably using multiple db images. 

```
version: '3'

services:
  app:
    build: .
    image: AwesomeShinyApp
    restart: unless-stopped
    user: shiny
    ports:
    - "8000:3838"
    depends_on:
    - db1
    - db2
  db1:
    image: postgres:10-alpine
    restart: unless-stopped
    environment:
      POSTGRES_PASSWORD: magicword
    volumes:
      - "./P001.sql.gz:/docker-entrypoint-initdb.d/P001.sql.gz:z"
  db2:
    image: postgres:10-alpine
    restart: unless-stopped
    environment:
      POSTGRES_PASSWORD: magicword
    volumes:
      - "./P002.sql.gz:/docker-entrypoint-initdb.d/P002.sql.gz:z"
```

`Found orphan containers`
docker-compose takes the name of the directory it is in as the default project name.

You can set a different project name by using -p or --project-name.
https://stackoverflow.com/questions/50947938/docker-compose-orphan-containers-warning
https://docs.docker.com/compose/reference/overview/#use--p-to-specify-a-project-name