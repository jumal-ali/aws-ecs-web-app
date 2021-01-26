variable "env" {
  type        = string
  description = "The environment in which to deploy the resources to. e.g. dev"
}

variable "container-image" {
  type        = string
  description = "Container Image e.g. dhimmat/node-web-app"
}

variable "container-tag" {
  type        = string
  description = "Container Tag e.g. latest"
}

variable "container-port" {
  type        = number
  description = "Container Port e.g. 8080"
}

variable "ecs-task-exec-role" {
  type        = string
  description = "Execution Role ARN for web-app task definition"
}

variable "ecs-cluster" {
  type        = string
  description = "Name of the ecs cluster web-app runs on"
}

variable "ecs-service" {
  type        = string
  description = "Name of the ecs service web-app is attached to"
}

variable "ecs-family" {
  type        = string
  description = "Name of the ecs task family name"
}