# Nexus 3.8 Docker Setup

## Docker pull and run

```
docker pull sonatype/nexus3:3.18.1

mkdir -p /data/nexus3 && chown -R 200 /data/nexus3

docker run -d -p 8081:8081 --name nexus3 -v  /data/nexus3:/nexus-data sonatype/nexus3

```

## References

- https://hub.docker.com/r/sonatype/nexus3