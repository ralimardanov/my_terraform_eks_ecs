# AWS IAM role for ECS Service
### I use awsvpc, that's why service policy for ECS isn't needed. I'll save it as example.

/*
data "aws_iam_policy_document" "ecs_service_policy" {
  statement {
    actions = var.ecs_service_iam_actions

    principals {
      type        = var.ecs_service_iam_type
      identifiers = var.ecs_service_iam_identifiers
    }
  }
}

resource "aws_iam_role" "ecs_service_role" {
  name               = var.ecs_service_iam_role_name
  assume_role_policy = data.aws_iam_policy_document.ecs_service_policy.json
}

resource "aws_iam_role_policy_attachment" "ecs-service-role-attachment" {
  role       = aws_iam_role.ecs_service_role.name
  policy_arn = var.ecs_iam_policy_arn
}
*/

# AWS IAM role for ECS EC2 instances
data "aws_iam_policy_document" "ecs_instance_policy" {
  statement {
    actions = var.ecs_ec2_iam_actions

    principals {
      type        = var.ecs_ec2_iam_type
      identifiers = var.ecs_ec2_iam_identifiers
    }
  }
}

resource "aws_iam_role" "ecs_instance_role" {
  name               = var.ecs_ec2_iam_role_name
  assume_role_policy = data.aws_iam_policy_document.ecs_instance_policy.json
}

resource "aws_iam_role_policy_attachment" "ecs_instance_policy_attachment" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = var.ecs_ec2_iam_policy_arn
}
resource "aws_iam_role_policy_attachment" "ecs_ssm_instance_policy_attachment" {
  role       = aws_iam_role.ecs_instance_role.name
  policy_arn = var.ecs_ec2_ssm_iam_policy_arn
}

resource "aws_iam_instance_profile" "ecs_instance_profile" {
  name = var.ecs_ec2_iam_instance_profile_name
  role = aws_iam_role.ecs_instance_role.name
}