variable "github_organization" {
  type        = string
  description = "GithubのOrganization名. or Organizationに所属していない場合Githubのユーザ名"
  default     = "i-s-23"
}

variable "github_repository" {
  type        = string
  description = "Githubのリポジトリ名"
  default     = "github-actions-multi-account-environments"
}

variable "s3_bucket_name" {
  type        = string
  description = "S3バケット名"
  default     = "s3-bucket-1234567890-abcdef-ghijklmnop"
}
