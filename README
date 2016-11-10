Create container that runs NGXINX as a caching proxy

Build with build -t nginx-content .
Run with docker run --name s3_proxy -d -p 8080:80 nginx-content

Access Files via 
http://localhost:8080/proxy_s3_file/[AWS S3 bucket name]]/[original file or path to file in AWS]

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

ADD config/proxy.conf/ /etc/nginx/conf.d/default.conf
config/proxy.conf/ overwrites the default config. Modify proxy.conf with your settings. N.B This is currently hardcoded to use the eu-west-1 AWS region.
Modify  set $s3_bucket        '$1.s3-eu-west-1.amazonaws.com';

