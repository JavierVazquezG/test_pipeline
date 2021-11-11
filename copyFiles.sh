#!/bin/bash

set -euo pipefail

CURRENTDATE=`date +"%Y/%m/%d"`
echo ${CURRENTDATE}
cd .
ls -l
#aws s3 cp ~/Reports s3://amount-shared-cicd-security-reports.use2/${CURRENTDATE} --region us-east-2