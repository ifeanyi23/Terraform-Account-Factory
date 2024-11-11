terraform {
  backend "s3" {
    bucket = "dev-670213391116-aftbootstrap-tfstate"
    key    = "state/terraform.tfstate"
    region = "ap-southeast-2"
    dynamodb_table = "ddb-aftbootstrap-state"
  }
}
