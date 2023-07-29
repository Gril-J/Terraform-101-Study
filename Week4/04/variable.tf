variable "bucket_name"{
    description = "S3 Bucket Name"
    type = list(string)
    default = ["gril-github-module-bucket1", "gril-github-module-bucket2"]
}