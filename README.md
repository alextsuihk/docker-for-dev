## Docker Deployment

### Important Note

- HTTPS (ssl) must be enabled to take full advantage of this application (including webpush notification)

### 1. Update .env & start docker containers

copy & update .env

```
 $ cp .env.sample .env
 $ nano .env
```

start docker containers in production mode

```
 $ docker-compose -f docker-compose.yml -f docker-compose-nginx.yml -f docker-compose-argonne.yml up
```

### 2. Initialize & enable HTTPS SSL cert

acquire & install ssl cert

```
 $ bash install-cert.sh www.your-domain.com
```

enable nginx SSL (for parsing environment variables, template is used instead of traditional conf file)
stop nginx docker container and uncomment the following lines, then restart nginx container.

```
 $ docker stop nginx
 $ nano ./conf/nginx/templates/default.conf.template

 #####

 listen 443 ssl http2;
 listen [::]:443 ssl http2;
 ...
 if ($scheme != "https") {
   return 301 https://$host$request_uri;
 }
 ...
 ssl_certificate /etc/letsencrypt/live/.....
 ssl_certificate_key /etc/letsencrypt/live/.....

 #####

 $ docker start nginx
```

### 2. Renew HTTPS-SSL cert every month

typically, certbot SSL cert is valid for 3 months. Certbot will not renew if cert is not about to renew. It does not hurt to try renewal every month.
update crontab

```
 $ crontab -e
```

add the following line to crontab

```
@monthly cd /your-path && docker-compose run --rm certbot renew; docker-compose restart # try to renew every month

```
