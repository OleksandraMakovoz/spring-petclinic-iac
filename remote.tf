data "aws_ssm_parameter" "db_username" {
  name            = "/petclinic/database/username"
  with_decryption = true
}

data "aws_ssm_parameter" "db_password" {
  name            = "/petclinic/database/password"
  with_decryption = true
}

data "aws_ssm_parameter" "master_db_username" {
  name            = "/petclinic/database/master_username"
  with_decryption = true
}

data "aws_ssm_parameter" "master_db_password" {
  name            = "/petclinic/database/master_password"
  with_decryption = true
}
