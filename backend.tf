terraform {
  backend "s3" {
    bucket = "petclinictfstate"
    key    = "prod/infra/terraform.tfstate"
    region = "eu-north-1"
  }
}
