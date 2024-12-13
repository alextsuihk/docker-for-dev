

echo "deploy without nginx"
echo  ""
docker-compose -f docker-compose.yml -f docker-compose-argonne.yml up -deploy

echo "deploy with nginx"
docker-compose -f docker-compose.yml -f docker-compose-nginx.yml -f docker-compose-argonne.yml up -deploy

## high-avaibility Mongo & Minio databases