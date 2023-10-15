provider "aws" {
  region = "eu-north-1"
}


resource "aws_ecs_cluster" "petclinic_cluster" {
  name = var.ecs_cluster_name
}

resource "aws_ecs_task_definition" "petclinic_task" {
  family = "DeployTask"
  cpu    = 1024
  memory = 3072

  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  execution_role_arn       = aws_iam_role.ecs_execution_role.arn
  task_role_arn            = aws_iam_role.ecs_execution_role.arn
  runtime_platform {
    cpu_architecture        = "X86_64"
    operating_system_family = "LINUX"
  }
  container_definitions = tostring(local.ecs_task.container_definitions)
}

resource "aws_iam_role" "ecs_execution_role" {
  name = "ecsTaskExecutionRole"
  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ecs-tasks.amazonaws.com"
        }
      }
    ]
  })

  dynamic "inline_policy" {
    for_each = local.deploy_task_iam_policies
    content {
      name   = inline_policy.key
      policy = inline_policy.value
    }
  }
}

resource "aws_ecs_service" "petclinic_service" {
  name            = "petclinic-app"
  cluster         = aws_ecs_cluster.petclinic_cluster.id
  task_definition = aws_ecs_task_definition.petclinic_task.arn
  launch_type     = "FARGATE"
  network_configuration {
    subnets = [
      "subnet-0628371ea3288c888",
      "subnet-0bdb6ead8a7106218",
      "subnet-063a8125c38c3b725"
    ]
    security_groups = ["sg-0de773a1c18ac7d23"]
  }
  depends_on = [aws_ecs_cluster.petclinic_cluster]
}
