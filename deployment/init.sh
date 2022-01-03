#!/bin/bash

aws s3 cp ./global-s3-assets s3://$TEMPLATE_OUTPUT_BUCKET/$SOLUTION_NAME/$VERSION --recursive --acl bucket-owner-full-control
aws s3 cp ./regional-s3-assets s3://$DIST_OUTPUT_BUCKET-$AWS_REGION/$SOLUTION_NAME/$VERSION --recursive --acl bucket-owner-full-control

#/bin/bash "$@"