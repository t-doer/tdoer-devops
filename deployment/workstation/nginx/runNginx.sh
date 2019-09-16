#!/usr/bin/env bash

docker run -d --name alpine-nginx -p80:80 -p443:443 -v /app/nginx/html:/opt/nginx/html -v /app/nginx/conf.d:/opt/nginx/conf.d  -v /app/nginx/cert:/opt/nginx/cert -v /app/nginx/acl:/opt/nginx/acl tdoer/alpine-nginx1.15.8:1.0.1