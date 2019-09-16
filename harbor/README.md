# Harbor

Run Harbor with `docker-compose`.

## 1. Download and Unzip Online Installer

```
wget https://storage.googleapis.com/harbor-releases/release-1.8.0/harbor-online-installer-v1.7.1.tgz
tar xvf harbor-online-installer-v1.7.1.tgz
mv harbor docker-compose
```

## 2. Configurations


The installation:

- Put all harbor files under `/app/harbor/`.
- Put ssl certificate and key files under `/app/harbor/cert`

#### 2.1 harbor.cfg

- hostname = harbor.tdoer.com
- ui_url_protocol = https
- ssl_cert = /app/harbor/cert/harbor.tdoer.com.crt
- ssl_cert_key = /app/harbor/cert/harbor.tdoer.com.key
- secretkey_path = /data/harbor/storage/

#### 2.2 docker-compose.yml

- /data/harbor/logs/:/var/log/docker/:z 
- /data/harbor/storage/registry:/storage:z
- /data/harbor/storage/database:/var/lib/postgresql/data:z
- /data/harbor/storage/config/:/etc/adminserver/config/:z
- /data/harbor/storage/secretkey:/etc/adminserver/key:z
- /data/harbor/storage/:/data/:z 
- /data/harbor/storage/secretkey:/etc/core/key:z
- /data/harbor/storage/ca_download/:/etc/core/ca/:z
- /data/harbor/storage/psc/:/etc/core/token/:z
- /data/harbor/storage/:/data/:z
- /data/harbor/job_logs:/var/log/jobs:z
- /data/harbor/storage/redis:/var/lib/redis

#### 2.3 docker-compose.chartmuseum.yml

- /data/harbor/storage/chart_storage:/chart_storage:z

#### 2.4 log

Need to setup syslog

```
    logging:
      driver: "syslog"
      options:  
        syslog-address: "tcp://127.0.0.1:1514"
```

## 3. Deploy and Run Harbor


#### 3.1 Prepare directories

  ```
  mkdir -p /app/harbor
  mkdir -p /data/harbor/storage
  ```

#### 3.2 Get configuration files and put ssl certificate and key files

  ```
  git clone https://github.com/t-doer/tdoer-devops
  cp -rf tdoer-devops/harbor/docker-compose/* /app/harbor/
  
  ## get and put ssl certificate and key files
  cp harbor.tdoer.com.crt /app/harbor/cert/
  cp harbor.tdoer.com.key /app/harbor/cert/
  
  ## Config docker daemon
  mkdir /etc/docker/certs.d/harbor.tdoer.com/
  cp harbor.tdoer.com.crt /etc/docker/certs.d/harbor.tdoer.com/
  ```

#### 3.3 Set syslog

```
vi /etc/rsyslog.conf
```  

```
# Provides TCP syslog reception
$ModLoad imtcp
$InputTCPServerRun 1514
``` 
 
```
systemctl restart rsyslog
``` 

#### 3.4 Config email in harbor.cfg

```
email_server = smtp.mydomain.com
email_server_port = 25
email_username = sample_admin@mydomain.com
email_password = abc
email_from = admin <sample_admin@mydomain.com>
email_ssl = false
email_insecure = false
```

#### 3.5 Install

```
cd /app/harbor
./install.sh --with-clair --with-chartmuseum
```

#### 3.6 Run with docker-compose

    ```
    Initialize containers and startup:
    
      docker-compose -f docker-compose.yml -f docker-compose.clair.yml -f docker-compose.chartmuseum.yml up -d
    
    Shutdown:
    
      docker-compose -f docker-compose.yml -f docker-compose.clair.yml -f docker-compose.chartmuseum.yml stop
    
    Start:
    
      docker-compose -f docker-compose.yml -f docker-compose.clair.yml -f docker-compose.chartmuseum.yml start
    
    Restart:
    
      docker-compose -f docker-compose.yml -f docker-compose.clair.yml -f docker-compose.chartmuseum.yml restart
    
    Shutdown and remove containers:
    
      docker-compose -f docker-compose.yml -f docker-compose.clair.yml -f docker-compose.chartmuseum.yml down
    
    ```  
    
#### 3.7 Initial access and change password

Initial admin's password is Harbor12345, login and change password 

```
https://harbor.tdoer.com
```