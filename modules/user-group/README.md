# AWS ElastiCache - User Group Terraform module

Terraform module which creates AWS ElastiCache users & group resources.

[![SWUbanner](https://raw.githubusercontent.com/vshymanskyy/StandWithUkraine/main/banner2-direct.svg)](https://github.com/vshymanskyy/StandWithUkraine/blob/main/docs/README.md)

## Usage

See [`examples`](https://github.com/terraform-aws-modules/terraform-aws-elasticache/tree/master/examples) directory for working examples to reference:

```hcl
module "elasticache_user_group" {
  source = "terraform-aws-modules/elasticache/aws//modules/user-group"

  user_group_id = "example"

  default_user = {
    user_id   = "defaultExample"
    passwords = ["password123456789"]
  }

  users = {
    moe = {
      access_string = "on ~* +@all"
      passwords     = ["password123456789"]
    }

    larry = {
      access_string = "on ~* +@all"

      authentication_mode = {
        type = "iam"
      }
    }

    curly = {
      access_string = "on ~* +@all"

      authentication_mode = {
        type      = "password"
        passwords = ["password123456789", "password987654321"]
      }
    }
  }

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }
}
```

## Examples

Examples codified under the [`examples`](https://github.com/terraform-aws-modules/terraform-aws-elasticache/tree/master/examples) are intended to give users references for how to use the module(s) as well as testing/validating changes to the source code of the module. If contributing to the project, please be sure to make any appropriate updates to the relevant examples to allow maintainers to test your changes and to keep the examples up to date for users. Thank you!

- [Memcached Cluster](https://github.com/terraform-aws-modules/terraform-aws-elasticache/tree/master/examples/memcached-cluster)
- [Redis Cluster](https://github.com/terraform-aws-modules/terraform-aws-elasticache/tree/master/examples/redis-cluster)
- [Redis Clustered Mode](https://github.com/terraform-aws-modules/terraform-aws-elasticache/tree/master/examples/redis-clustered-mode)
- [Redis Global Replication Group](https://github.com/terraform-aws-modules/terraform-aws-elasticache/tree/master/examples/redis-global-replication-group)
- [Redis Replication Group](https://github.com/terraform-aws-modules/terraform-aws-elasticache/tree/master/examples/redis-replication-group)

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | >= 5.73 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_aws"></a> [aws](#provider\_aws) | >= 5.73 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [aws_elasticache_user.default](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_user) | resource |
| [aws_elasticache_user.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_user) | resource |
| [aws_elasticache_user_group.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_user_group) | resource |
| [aws_elasticache_user_group_association.this](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/elasticache_user_group_association) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_create"></a> [create](#input\_create) | Determines whether resources will be created (affects all resources) | `bool` | `true` | no |
| <a name="input_create_default_user"></a> [create\_default\_user](#input\_create\_default\_user) | Determines whether a default user will be created | `bool` | `true` | no |
| <a name="input_create_group"></a> [create\_group](#input\_create\_group) | Determines whether a user group will be created | `bool` | `true` | no |
| <a name="input_default_user"></a> [default\_user](#input\_default\_user) | A map of default user attributes | `any` | `{}` | no |
| <a name="input_default_user_id"></a> [default\_user\_id](#input\_default\_user\_id) | The ID of the default user | `string` | `"default"` | no |
| <a name="input_engine"></a> [engine](#input\_engine) | The current supported value is `REDIS` | `string` | `"redis"` | no |
| <a name="input_tags"></a> [tags](#input\_tags) | A map of tags to add to all resources | `map(string)` | `{}` | no |
| <a name="input_user_group_id"></a> [user\_group\_id](#input\_user\_group\_id) | The ID of the user group | `string` | `""` | no |
| <a name="input_users"></a> [users](#input\_users) | A map of users to create | `any` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_group_arn"></a> [group\_arn](#output\_group\_arn) | The ARN that identifies the user group |
| <a name="output_group_id"></a> [group\_id](#output\_group\_id) | The user group identifier |
| <a name="output_users"></a> [users](#output\_users) | A map of users created and their attributes |
<!-- END_TF_DOCS -->

## License

Apache-2.0 Licensed. See [LICENSE](https://github.com/terraform-aws-modules/terraform-aws-elasticache/blob/master/LICENSE).
