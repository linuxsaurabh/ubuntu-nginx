#!/bin/bash

# Copy nginx files from S3

if [ $S3_Enabled == "True" ]
then
	aws s3 cp s3://$bucket/$path /data/www/index.html
else
	echo "s3 is not enabled"
fi
