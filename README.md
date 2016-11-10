## Description
Create container that runs NGXINX as a caching proxy for AWS S3

# Example
A direct request to AWS S3
https://s3-build-cache-example.s3-eu-west-1.amazonaws.com/LoremIpsum.txt

A proxied request that should be cached locally after first request
http://localhost:8080/proxy_s3_file/3-build-cache-example/LoremIpsum.txt

http://[$HOST_OR_IP]:8080/proxy_s3_file/[$AWS_BUCKET]/[$FILENAME]

[$HOST_OR_IP] - In a standard local setup this will be localhost|127.0.0.1. Remote Docker installs should give you a hostname or IP to use

[$AWS_BUCKET] - The name of your AWS Bucket. This is either the portion of the hostname before '.s3-eu-west-1.amazonaws.com' or the first part of the path. In the example provided:

The **s3-build-cache-example** in: 
https://s3-build-cache-example.s3-eu-west-1.amazonaws.com/LoremIpsum.txt
or
https://s3-eu-west-1.amazonaws.com/s3-build-cache-example/LoremIpsum.txt

[$FILENAME] - The filename including path to AWS S3 object
https://s3-eu-west-1.amazonaws.com/s3-build-cache-example/**LoremIpsum.txt**


# Motivation
S3 is a realiable and cheap storage solution but download times can slow down builds especially whilst developing locally. Adding an intermediary cache that can handle large files *should* speed things up. Using aws cli etc may yield better results depending on the use case

# Installation
Clone the git repo
``` Shell
git clone git@github.com:andywirv/s3-build-cache.git
```

Build docker container with 
``` Shell
cd s3-build-cache
docker build -t nginx-content .
```

Run container with 
``` Shell
docker run --name s3_proxy -d -p 8080:80 nginx-content
```
N.B This assumes that you do not already have something bound to port 8080 on your docker host. If your docker host is a virtual machine you will need to port map 8080 on the guest to 8080 on the host for the example request below to work

Access Files via
```
http://localhost:8080/proxy_s3_file/[AWS S3 bucket name]]/[original file or path to file in AWS]
```

Example Response Headers. X-Cached: indicates HIT/MISS
``` Shell
HTTP/1.1 200 OK
< Server: nginx/1.11.5
< Date: Thu, 10 Nov 2016 00:26:23 GMT
< Content-Type: image/png
< Content-Length: 38747
< Connection: keep-alive
< Last-Modified: Wed, 09 Nov 2016 19:41:32 GMT
< ETag: "4034157f5f6b92113628e5262e272d77"
< X-Cached: HIT
< Accept-Ranges: bytes
```
``` Shell
ADD config/proxy.conf/ /etc/nginx/conf.d/default.conf
```

config/proxy.conf/ overwrites the default/package NGINX config. Modify proxy.conf with your settings. N.B This is currently hardcoded to use the **eu-west-1** AWS region.
Modify  
``` Shell
set $s3_bucket        '$1.s3-eu-west-1.amazonaws.com';
```

