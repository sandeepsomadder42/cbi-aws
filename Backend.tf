terraform {
  backend "s3" {
    bucket = "tf-state-sandy-bucket"
    key = "main"
    region = "us-east-1"
    dynamodb_table = "my-dynamo-db-table-tf"
  }
}