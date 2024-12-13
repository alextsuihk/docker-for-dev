# syntax: ./install-cert.sh www.example.com
# NOTE: "//" (double slash) is needed for windows (git-scm) compatibility
docker-compose -f docker-compose-nginx.yml run --rm certbot certonly --webroot --webroot-path //var/www/certbot/ -d $1
