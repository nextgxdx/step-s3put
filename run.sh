#!/bin/sh
set -e
cd $HOME
if [ ! -n "$WERCKER_S3PUT_AWSCLI_FILE" ]
then
  fail 'missing or empty option file, please check wercker.yml'
fi

if [ ! -n "$WERCKER_S3PUT_AWSCLI_BUCKET" ]
then
  fail 'missing or empty option bucket, please check wercker.yml'
fi

if ! type aws &> /dev/null ;
then
  fail 'aws-cli not found, please run on a container with aws-cli installed'
fi

info 'starting s3 upload'

cd /pipeline/output
pwd
ls -alh

set +e
for file in $WERCKER_S3PUT_AWSCLI_FILE ; do
  fname=$(basename $file)
  debug "aws s3api put-object --bucket '$WERCKER_S3PUT_AWSCLI_BUCKET' --key '$WERCKER_S3PUT_AWSCLI_KEY_PREFIX$fname' --body '$file' $WERCKER_S3PUT_AWSCLI_OPTIONS"
  #sync_output=$(aws s3api put-object --bucket '$WERCKER_S3PUT_AWSCLI_BUCKET' --key '$WERCKER_S3PUT_AWSCLI_KEY_PREFIX$file' --body '$file' $WERCKER_S3PUT_AWSCLI_OPTIONS)
  #if [[ $? -ne 0 ]];then
  #  warning $sync_output
  #  fail 'aws-cli failed';
  #fi
done

success 'finished s3 upload';
set -e
