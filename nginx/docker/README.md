# Nginx15.8 Docker Setup

## Docker pull and run

```
docker pull tdoer/alpine-nginx1.15.8:1.0.0

mkdir -p /data/nexus3 && chown -R 200 /data/nexus3

docker run --name tdoer-alpine-nginx -p80:80 -v /app/www:/opt/nginx/html -v /tmp/test/conf.d:/opt/nginx/conf.d --privileged=true tdoer/alpine-nginx1.15.8:1.0.0

```

## References

- https://hub.docker.com/r/tdoer/alpine-nginx1.15.8