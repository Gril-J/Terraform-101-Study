variable "bucket_name" {
  description = "S3 Bucket Name"
}

variable "block_acl" {
  description = "S3 Bucket ACL"
  type = bool
}

variable "public_policy" {
  description = "S3 Bucket ACL"
  type = bool
}

variable "ignore_policy" {
  description = "S3 Bucket ACL"
  type = bool
}

variable "restrict_public" {
  description = "restrict_public"
  type = string
}