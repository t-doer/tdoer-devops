# Workstation

The document describe how to install the services below on workstation machine.

- nexus
- nginx

## Steps to run

1. Pull from GitHub

    ```
    git clone https://github.com/t-doer/tdoer-devops 
    ```

2. Prepare directories on workstation.

    Put applications under `/app` and data under `/data`.

    ```
    cp -r tdoer-devops/deployment/workstation/* /app
    
    chown -R nginx:nginx /app/nginx
    mkdir -p /data/nexus3 && chown -R 200 /data/nexus3
    ```

3. Update `localhost` to the ip of machine to run on in `/opt/nginx/conf.d/upstream.conf`

4. Put ssl certificates into `/opt/nginx/cert/`

5. Run nexus and nginx

```
cd /app/nginx & ./runNginx.sh
cd /app/nexus & ./runNexus.sh
```

## Note 

Nexus's website dose not support https, please access it with http.

Nexus admin's initial password, please see the file in nexus's container: `/opt/sonatype/sonatype-work/nexus3/admin.password`

