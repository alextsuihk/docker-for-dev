#!/bin/bash

###############################################################################
# This script adds user, creates minio buckets (with policy)
###############################################################################
sleep 3 # wait x seconds for minio ready (to be safe)

HOST=$1 # hostname of minio

# setup alias
mc alias set myminio http://$HOST:9000 root $PASSWORD

## make buckets (one public & one private)
mc mb myminio/${PUBLIC_BUCKET}
mc mb myminio/${PRIVATE_BUCKET}
mc policy set download myminio/${PUBLIC_BUCKET} # public bucket allows GET
mc policy set download myminio/react # react bucket allows GET

## add user
mc admin user add myminio $USER "$PASSWORD"

## add & set policy
cp template.json ${USER}.json
sed -i "s/PUBLIC/${PUBLIC_BUCKET}/" ${USER}.json
sed -i "s/PRIVATE/${PRIVATE_BUCKET}/" ${USER}.json

mc admin policy add myminio $USER ${USER}.json
mc admin policy set myminio $USER user=$USER

rm ${USER}.json