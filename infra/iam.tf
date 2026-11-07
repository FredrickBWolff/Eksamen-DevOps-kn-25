data "aws_iam_policy_document" "ecs_tasks_trust" {
    statement {
        actions = ["sts:AssumeRole"]
        principals {
          type        = "Service"
          identifiers = ["ecs-tasks.amazonaws.com"]
        }
    }
}

resource "aws_iam_role" "task" {
    name               = "wishifai-task-role-${var.kandidatnummer}"
    assume_role_policy = data.aws_iam_policy_document.ecs_tasks_trust.json
}

resource "aws_iam_role_policy" "task" {
    role = aws_iam_role.task.id

    policy = jsonencode({
        Version = "2012-10-17"
        Statement = [
            {
                Effect   = "Allow",
                Action   = "s3:PutObject"
                Resource = "${aws_s3_bucket.images.arn}/*"
            },
            {
                Effect   = "Allow"
                Action   = ["rekognition:DetectLabels"]
                Resource = "*"
            },
            {
                Effect   = "Allow"
                Action   = ["bedrock:InvokeModel"]
                Resource = "*"
            }
        ]
    })
}