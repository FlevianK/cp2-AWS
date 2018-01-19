provider "aws" {
  shared_credentials_file = "${var.credentialsfile}"
  region     = "${var.region}"
}