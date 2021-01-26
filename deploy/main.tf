locals {
  service = "${var.env}-${var.ecs-family}"
}

resource "aws_ecs_task_definition" "web-app" {
  family = data.aws_ecs_task_definition.web-app.family
  container_definitions = templatefile("${path.module}/ecs-container-definitions/web-app.tpl", {
    image = var.container-image
    tag   = var.container-tag
    port  = var.container-port
    mem   = data.aws_ecs_container_definition.web-app.memory
    cpu   = data.aws_ecs_container_definition.web-app.cpu
  })

  requires_compatibilities = ["FARGATE"]
  network_mode             = data.aws_ecs_task_definition.web-app.network_mode
  memory                   = data.aws_ecs_container_definition.web-app.memory
  cpu                      = data.aws_ecs_container_definition.web-app.cpu
  execution_role_arn       = data.aws_iam_role.ecs-task-exec-role.arn

  tags = {
    Terraform   = "true"
    Environment = var.env
    Project     = "ECS Beta"
    image       = var.container-image
    tag         = var.container-tag
    port        = var.container-port
    mem         = data.aws_ecs_container_definition.web-app.memory
    cpu         = data.aws_ecs_container_definition.web-app.cpu
    service     = local.service
  }
}

resource "null_resource" "update-service" {
  provisioner "local-exec" {
    command     = "tf-scripts/update-ecs-service.sh \"${var.ecs-cluster}\" \"${var.ecs-service}\" \"${local.service}:${aws_ecs_task_definition.web-app.revision}\""
    interpreter = ["/bin/bash", "-c"]
  }

  depends_on = [aws_ecs_task_definition.web-app]
}

data "aws_ecs_task_definition" "web-app" {
  task_definition = local.service
}

data "aws_ecs_container_definition" "web-app" {
  task_definition = data.aws_ecs_task_definition.web-app.family
  container_name  = var.ecs-family
}

data "aws_iam_role" "ecs-task-exec-role" {
  name = var.ecs-task-exec-role
}

output "latest-task-revision" {
  value = "${local.service}:${aws_ecs_task_definition.web-app.revision}"
}

output "deployed-image" {
  value = "${var.container-image}:${var.container-tag}"
}