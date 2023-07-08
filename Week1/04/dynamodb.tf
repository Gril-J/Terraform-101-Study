resource "aws_dynamodb_table" "terraform_backend" {
  name         = "${var.namespace}-terraform-backend"
  billing_mode = "PAY_PER_REQUEST"
  hash_key     = "LockID"

  attribute {
    name = "LockID"
    type = "S"
  }
}
