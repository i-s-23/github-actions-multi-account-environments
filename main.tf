module "s3_bucket" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "4.1.1"

  bucket = var.s3_bucket_name

  control_object_ownership = true
  object_ownership         = "BucketOwnerEnforced" # ACL無効化設定

  versioning = {
    enabled = true
  }
}


# S3バケットに対してアクセスできるようにIAMポリシーを作成する
resource "aws_iam_policy" "s3_push_policy" {

  name = "s3-access"
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Effect   = "Allow",
        Action   = "s3:ListAllMyBuckets",
        Resource = "*"
      },
      {
        Effect   = "Allow",
        Action   = "s3:ListBucket",
        Resource = "arn:aws:s3:::*"
      },
      {
        Effect   = "Allow"
        Resource = "${module.s3_bucket.s3_bucket_arn}/*"
        Action = [
          "s3:GetObject",
          "s3:PutObject",
          "s3:DeleteObject",
        ]
      }
    ]
  })
}

# OIDCを利用してGithubActionsがAWSリソースにアクセスできるようにする
module "oidc_github" {
  source  = "unfunco/oidc-github/aws"
  version = "1.7.1"

  github_repositories = [
    "${var.github_organization}/${var.github_repository}"
  ]
  iam_role_policy_arns = [
    aws_iam_policy.s3_push_policy.arn
  ]
}

provider "aws" {
  region = "us-east-1"
}
