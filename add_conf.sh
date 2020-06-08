#!/bin/bash

# Copy nginx files from S3

if [ $S3_Enabled == "True" ]
then
	aws s3 cp s3://$bucket/$path /data/www/index.html
        aws s3 cp s3://$bucket/$config /etc/nginx/conf.d/default.conf
else
	echo "s3 is not enabled"
fi
