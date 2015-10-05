# s3put-awscli

[Wercker] step to upload files to [Amazon S3] using [aws-cli].

You can use application and deployment variables in wercker.

View this step in the [wercker directory][wd]

## Options

* `bucket` (required) The name of the bucket to upload to.
* `file` (optional) The name of the file or directory to upload.
  * Relative file paths are relative to the build's `$WERCKER_OUTPUT_DIR`.
  * If this points to a directory, all files in that directory will be uploaded.
  * Defaults to the build's `$WERCKER_OUTPUT_DIR` directory.
* `key_prefix` (optional) Prefix for the s3 object keys.
* `options` (optional) Additional parameters for the AWSCLI.

## Example

    - s3put:
        file:       /pipeline/output/my-project.tar.gz
        bucket:     mybucket
        key_prefix: myproject/
        options:    --acl bucket-owner-full-control

[Wercker]: http://wercker.com
[Amazon S3]: http://aws.amazon.com/s3
[wd]: https://app.wercker.com/#applications/5612a5904010ec244a242c71/tab/details
[aws-cli]: https://github.com/aws/aws-cli
