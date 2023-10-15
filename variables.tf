variable "db_username_parameter_name" {
  type        = string
  default     = "/petclinic/database/username"
  description = "Name of the RDS username parameter in Parameter Store"
}

variable "db_password_parameter_name" {
  type        = string
  default     = "/petclinic/database/password"
  description = "Name of the RDS password parameter in Parameter Store"
}

variable "ecs_cluster_name" {
  type        = string
  default     = "ProdCluster"
  description = "Name of the ECS cluster"
}

variable "ecs_service_name" {
  type        = string
  default     = "petclinic-app"
  description = "Name of the ECS service"
}

variable "ecr_repository_name" {
  type        = string
  default     = "petclinic-ecr-images"
  description = "Name of the ECR repository for the Spring PetClinic Docker image"
}
variable "db_name" {
  type        = string
  default     = "petclinic"
  description = "Name of the database"
}

variable "create_if_not_exists" {
  type        = bool
  description = "Create the RDS if it doesn't exist"
  default     = true
}
