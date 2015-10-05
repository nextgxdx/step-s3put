#!/bin/sh
set -e
cd $HOME
if [ ! -n "$WERCKER_S3PUT_AWSCLI_FILE" ]
then
  WERCKER_S3PUT_AWSCLI_FILE=$WERCKER_ROOT
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


set +e
if [ -d $WERCKER_S3PUT_AWSCLI_FILE ] ;
then
  cd $WERCKER_S3PUT_AWSCLI_FILE
  for file in $WERCKER_S3PUT_AWSCLI_FILE/* ; do
    if [ -f $file ];
    then
      fname=$(basename $file)
      debug "aws s3api put-object --bucket '$WERCKER_S3PUT_AWSCLI_BUCKET' --key '$WERCKER_S3PUT_AWSCLI_KEY_PREFIX$fname' --body '$file' $WERCKER_S3PUT_AWSCLI_OPTIONS"
      sync_output=$(aws s3api put-object --bucket '$WERCKER_S3PUT_AWSCLI_BUCKET' --key '$WERCKER_S3PUT_AWSCLI_KEY_PREFIX$fname' --body '$file' $WERCKER_S3PUT_AWSCLI_OPTIONS)
      if [[ $? -ne 0 ]];then
        warning $sync_output
        fail 'aws-cli failed';
      fi
    fi
  done
elif [ -f $WERCKER_S3PUT_AWSCLI_FILE ] ;
then
  cd $WERCKER_ROOT
  fname=$(basename $WERCKER_S3PUT_AWSCLI_FILE)
  debug "aws s3api put-object --bucket '$WERCKER_S3PUT_AWSCLI_BUCKET' --key '$WERCKER_S3PUT_AWSCLI_KEY_PREFIX$fname' --body '$WERCKER_S3PUT_AWSCLI_FILE' $WERCKER_S3PUT_AWSCLI_OPTIONS"
  sync_output=$(aws s3api put-object --bucket '$WERCKER_S3PUT_AWSCLI_BUCKET' --key '$WERCKER_S3PUT_AWSCLI_KEY_PREFIX$fname' --body '$WERCKER_S3PUT_AWSCLI_FILE' $WERCKER_S3PUT_AWSCLI_OPTIONS)
  if [[ $? -ne 0 ]];then
    warning $sync_output
    fail 'aws-cli failed';
  fi
else
  fail "file or folder $WERCKER_S3PUT_AWSCLI_FILE not found"
fi

success 'finished s3 upload';
set -e
