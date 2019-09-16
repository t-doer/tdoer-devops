#!/usr/bin/env bash

docker run -d -p 8081:8081 --name nexus3 -v  /data/nexus3:/nexus-data sonatype/nexus3