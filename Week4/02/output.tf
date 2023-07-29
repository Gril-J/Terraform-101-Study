output "bucket_id" {
  value = [
    for k in module.s3_bucket_module: k.bucket_id
  ]
