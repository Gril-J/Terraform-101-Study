variable "bucket_name"{
    description = "S3 Bucket Name"
    type = list(string)
    default = ["gril-terraform101-module-bucket1", "gril-terraform101-module-bucket2"]
}