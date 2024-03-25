# github-actions-multi-account-environments

- GitHub ActionsでS3にデプロイする際に、複数のAWSアカウントを使い分けるためのサンプルリポジトリです

## Usage

- S3などAWSリソースを作成するためのTerraformコードを実行します
 - `s3_bucket_name` など variables.tf は各々の環境で適切な値を設定してください

```bash
terraform init

terraform apply
```