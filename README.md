# mycli-docker
mycli in a tiny Docker image powered by Alpine Linux

# How to use this image

Print help:

```bash
docker run --rm diyan/mycli --help
```

Run MySQL server if you don't have it:

```bash
docker run -d --name=mysql \
  -p 3306:3306 \
  -e MYSQL_ROOT_PASSWORD=secret \
  mysql:5.7
```

Run mycli:

```bash
docker run --rm -ti --name=mycli \
  --link=mysql:mysql \
  diyan/mycli \
  --host=mysql \
  --database=mysql \
  --user=root \
  --password=secret
```
