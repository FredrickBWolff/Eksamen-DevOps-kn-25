data "aws_iam_policy_document" "esc_tasks_trust" {
    statement {
        actions = ["sts:AssumeRole"]
        principals {
          type        = "Service"
          identifiers = ["ecs-tasks.amazonaws.com"]
        }
    }
}

resource "aws_iam_role" "task_execution" {
    name               = "wishifai-task-role-${var.kandidatnummer}"
    assume_role_policy = data.aws_iam_policy_document.esc_tasks_trust.json
}

resource "aws_iam_role_policy" "task" {
    role = aws_iam_role.task.id

    policy = jsoncode({
        Version = "2012-10-17"
        Statement = [
            {
                Effect   = "Allow",
                Action   = "s3:PutObject"
                Resource = "${aes_s3_bucket.image.arn}"
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