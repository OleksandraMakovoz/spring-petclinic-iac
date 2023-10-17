locals {
  deploy_task_iam_policies = {
    readParameterStore = jsonencode({
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Sid" : "VisualEditor1",
          "Effect" : "Allow",
          "Action" : [
            "kms:Decrypt",
            "secretsmanager:GetSecretValue",
            "ssm:GetAutomationExecution",
            "ssm:GetDefaultPatchBaseline",
            "ssm:DescribeDocument",
            "ssm:DescribeInstancePatches",
            "ssm:GetPatchBaselineForPatchGroup",
            "ssm:PutConfigurePackageResult",
            "ssm:GetParameter",
            "ssm:GetMaintenanceWindowExecutionTaskInvocation",
            "ssm:DescribeAutomationExecutions",
            "ssm:GetManifest",
            "ssm:GetMaintenanceWindowTask",
            "ssm:DescribeAutomationStepExecutions",
            "ssm:DescribeParameters",
            "ssm:DescribeInstancePatchStates",
            "ssm:DescribeInstancePatchStatesForPatchGroup",
            "ssm:GetDocument",
            "ssm:GetInventorySchema",
            "ssm:GetParametersByPath",
            "ssm:GetMaintenanceWindow",
            "ssm:DescribeInstanceAssociationsStatus",
            "ssm:DescribeAssociationExecutionTargets",
            "ssm:GetPatchBaseline",
            "ssm:DescribeInstanceProperties",
            "ssm:DescribeAssociation",
            "ssm:GetConnectionStatus",
            "ssm:GetMaintenanceWindowExecutionTask",
            "ssm:GetDeployablePatchSnapshotForInstance",
            "ssm:GetOpsItem",
            "ssm:GetParameterHistory",
            "ssm:GetMaintenanceWindowExecution",
            "ssm:DescribeInventoryDeletions",
            "ssm:DescribeEffectiveInstanceAssociations",
            "ssm:GetParameters",
            "ssm:GetInventory",
            "ssm:GetOpsSummary",
            "ssm:DescribeActivations",
            "ssm:GetOpsMetadata",
            "ssm:DescribeOpsItems",
            "ssm:GetCommandInvocation",
            "ssm:DescribeInstanceInformation",
            "ssm:DescribeDocumentParameters",
            "ssm:DescribeEffectivePatchesForPatchBaseline",
            "ssm:GetServiceSetting",
            "ssm:DescribeAssociationExecutions",
            "ssm:GetCalendar",
            "ssm:DescribeDocumentPermission",
            "ssm:GetCalendarState",
            "ssm:DescribeAvailablePatches"
          ],
          "Resource" : [
            "arn:aws:ssm:eu-north-1:362447113011:parameter/*",
            "arn:aws:secretsmanager:eu-north-1:362447113011:secret:*",
            "arn:aws:kms:eu-north-1:362447113011:key/*"
          ]
        }
      ]
    }),
    propertyStorePolicy = jsonencode({
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "ssm:DescribeAssociation",
            "ssm:GetDeployablePatchSnapshotForInstance",
            "ssm:GetDocument",
            "ssm:DescribeDocument",
            "ssm:GetManifest",
            "ssm:ListAssociations",
            "ssm:ListInstanceAssociations",
            "ssm:PutInventory",
            "ssm:PutComplianceItems",
            "ssm:PutConfigurePackageResult",
            "ssm:UpdateAssociationStatus",
            "ssm:UpdateInstanceAssociationStatus",
            "ssm:UpdateInstanceInformation"
          ],
          "Resource" : "*"
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "ssmmessages:CreateControlChannel",
            "ssmmessages:CreateDataChannel",
            "ssmmessages:OpenControlChannel",
            "ssmmessages:OpenDataChannel"
          ],
          "Resource" : "*"
        },
        {
          "Effect" : "Allow",
          "Action" : [
            "ec2messages:AcknowledgeMessage",
            "ec2messages:DeleteMessage",
            "ec2messages:FailMessage",
            "ec2messages:GetEndpoint",
            "ec2messages:GetMessages",
            "ec2messages:SendReply"
          ],
          "Resource" : "*"
        }
      ]
    }),
    ddPolicy = jsonencode({
      "Version" : "2012-10-17",
      "Statement" : [
        {
          "Effect" : "Allow",
          "Action" : [
            "ecs:ListClusters",
            "ecs:ListContainerInstances",
            "ecs:DescribeContainerInstances"
          ],
          "Resource" : "*"
        }
      ]
    })
  }

  ecs_task = {
    container_definitions = <<DEFINITION
    [
    {
        "name": "petclinic",
        "image": "362447113011.dkr.ecr.eu-north-1.amazonaws.com/petclinic-ecr-images:latest",
        "cpu": 0,
        "portMappings": [
            {
                "name": "petclinic-80-tcp",
                "containerPort": 80,
                "hostPort": 80,
                "protocol": "tcp",
                "appProtocol": "http"
            }
        ],
        "essential": true,
        "environment": [],
        "mountPoints": [],
        "volumesFrom": [],
        "secrets": [
            {
                "name": "MYSQL_URL",
                "valueFrom": "arn:aws:ssm:eu-north-1:362447113011:parameter/MYSQL_URL"
            },
            {
                "name": "MYSQL_PASS",
                "valueFrom": "arn:aws:ssm:eu-north-1:362447113011:parameter/MYSQL_PASS"
            },
            {
                "name": "MYSQL_USER",
                "valueFrom": "arn:aws:ssm:eu-north-1:362447113011:parameter/MYSQL_USER"
            }
        ],
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-create-group": "true",
                "awslogs-group": "/ecs/DeployTask",
                "awslogs-region": "eu-north-1",
                "awslogs-stream-prefix": "ecs"
            }
        }
    }
]
    DEFINITION
  }
}
