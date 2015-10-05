# s3put-awscli

[Wercker] step to upload files to [Amazon S3] using [aws-cli].

You can use application and deployment variables in wercker.

View this step in the [wercker directory][wd]

## Options

* `file` (required) The name or pattern of the file(s) to upload.
* `bucket` (required) The name of the bucket to upload to.
* `key_prefix` (optional) Prefix for the s3 object keys.
* `options` (optional) Additional parameters for the AWSCLI.

## Example

    - s3put:
        file:       *.tar.gz
        bucket:     mybucket
        key_prefix: myproject/
        options:    --acl bucket-owner-full-control

[Wercker]: http://wercker.com
[Amazon S3]: http://aws.amazon.com/s3
[wd]: https://app.wercker.com/
[aws-cli]: https://github.com/aws/aws-cli
