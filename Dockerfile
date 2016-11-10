FROM nginx
RUN mkdir /var/cache/nginx/defaultsite
RUN mkdir -p /tmp/cache/nginx
ADD webfiles/ /usr/share/nginx/html
ADD config/proxy.conf/ /etc/nginx/conf.d/default.conf
