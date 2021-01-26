locals {
  service = "${var.env}-web-app"
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
  execution_role_arn       = var.ecs-task-exec-role

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
    command     = "./update-ecs-service.sh \"${var.ecs-cluster}\" \"${var.ecs-service}\" \"${local.service}:${aws_ecs_task_definition.web-app.revision}\""
    interpreter = ["/bin/bash", "-c"]
  }

  depends_on = [aws_ecs_task_definition.web-app]
}

data "aws_ecs_task_definition" "web-app" {
  task_definition = local.service
}

data "aws_ecs_container_definition" "web-app" {
  task_definition = data.aws_ecs_task_definition.web-app.family
  container_name  = "web-app"
}

output "latest-task-revision" {
  value = "${local.service}:${aws_ecs_task_definition.web-app.revision}"
}