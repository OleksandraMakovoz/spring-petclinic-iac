resource "aws_db_instance" "petclinic" {
  allocated_storage    = 10
  storage_type         = "gp2"
  engine               = "mysql"
  engine_version       = "8.0.33"
  instance_class       = "db.t3.micro"
  db_name              = var.db_name
  username             = "admin" #data.aws_ssm_parameter.master_db_username.value
  password             = data.aws_ssm_parameter.master_db_password.value
  parameter_group_name = "default.mysql8.0"
  identifier           = "rds-mysql-petclinic"
  storage_encrypted    = false
  apply_immediately    = true
  publicly_accessible  = false
  skip_final_snapshot  = true
}
