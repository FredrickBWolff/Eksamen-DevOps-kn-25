resource "aws_ecs_express_gateway_service" "app" {
  service_name            = "wishifai-${var.kandidatnummer}"
  execution_role_arn      = "arn:aws:iam::244530008913:role/ecsTaskExecutionRole"
  infrastructure_role_arn = "arn:aws:iam::244530008913:role/service-role/ecsInfrastructureRoleForExpressServices"
  task_role_arn           = aws_iam_role.task.arn
  health_check_path       = "/api/health"

  primary_container {
    image          = "244530008913.dkr.ecr.${var.region}.amazonaws.com/${var.ecr_repository}:${var.image_tag}"
    container_port = 8080

    environment {
      name  = "S3_BUCKET"
      value = aws_s3_bucket.images.bucket
    }
  }

  depends_on = [aws_iam_role_policy.task]
}