# Changelog

All notable changes to this project will be documented in this file.

## [1.7.0](https://github.com/terraform-aws-modules/terraform-aws-elasticache/compare/v1.6.2...v1.7.0) (2025-07-25)


### Features

* Add option to customize global_replication_group_id_suffix ([#47](https://github.com/terraform-aws-modules/terraform-aws-elasticache/issues/47)) ([2f30ea2](https://github.com/terraform-aws-modules/terraform-aws-elasticache/commit/2f30ea2b2fdd017c747262061095b66bc6bf09a7))

## [1.6.2](https://github.com/terraform-aws-modules/terraform-aws-elasticache/compare/v1.6.1...v1.6.2) (2025-07-21)


### Bug Fixes

* Use lowercase form of default engine `"redis"` ([#41](https://github.com/terraform-aws-modules/terraform-aws-elasticache/issues/41)) ([0695d6a](https://github.com/terraform-aws-modules/terraform-aws-elasticache/commit/0695d6a0512b144651cd11dea5929f48730fb916))

## [1.6.1](https://github.com/terraform-aws-modules/terraform-aws-elasticache/compare/v1.6.0...v1.6.1) (2025-07-21)


### Bug Fixes

* Remove restriction on engine to allow Valkey cluster creation ([#44](https://github.com/terraform-aws-modules/terraform-aws-elasticache/issues/44)) ([b3fe278](https://github.com/terraform-aws-modules/terraform-aws-elasticache/commit/b3fe278d2f12a76a34d6b32b847a58c3b210f7f1))

## [1.6.0](https://github.com/terraform-aws-modules/terraform-aws-elasticache/compare/v1.5.0...v1.6.0) (2025-03-30)


### Features

* Set `create_before_destroy` on subnet group ([#29](https://github.com/terraform-aws-modules/terraform-aws-elasticache/issues/29)) ([9133f1e](https://github.com/terraform-aws-modules/terraform-aws-elasticache/commit/9133f1ec80c4cefef8dd5a763f6f6d9e4526276e))

## [1.5.0](https://github.com/terraform-aws-modules/terraform-aws-elasticache/compare/v1.4.1...v1.5.0) (2025-03-29)


### Features

* Add elasticache cluster timeouts ([#33](https://github.com/terraform-aws-modules/terraform-aws-elasticache/issues/33)) ([41e5c75](https://github.com/terraform-aws-modules/terraform-aws-elasticache/commit/41e5c75b2ea15a8631f8bb9f7f73ad5d868eeddf))

## [1.4.1](https://github.com/terraform-aws-modules/terraform-aws-elasticache/compare/v1.4.0...v1.4.1) (2024-12-02)


### Bug Fixes

* Change cloudwatch log group output to include all created log groups ([#19](https://github.com/terraform-aws-modules/terraform-aws-elasticache/issues/19)) ([cdc870e](https://github.com/terraform-aws-modules/terraform-aws-elasticache/commit/cdc870e425fd34a93f3e38adccf8eb4c8fd1ef1a))

## [1.4.0](https://github.com/terraform-aws-modules/terraform-aws-elasticache/compare/v1.3.0...v1.4.0) (2024-11-29)


### Features

* Support Valkey ([#26](https://github.com/terraform-aws-modules/terraform-aws-elasticache/issues/26)) ([6b1b5aa](https://github.com/terraform-aws-modules/terraform-aws-elasticache/commit/6b1b5aa4576942bad13a6c8a8420e958a7327fad))

## [1.3.0](https://github.com/terraform-aws-modules/terraform-aws-elasticache/compare/v1.2.4...v1.3.0) (2024-10-17)


### Features

* Support `aws_elasticache_user_group_association.timeouts` and `aws_elasticache_replication_group.cluster_mode` ([#21](https://github.com/terraform-aws-modules/terraform-aws-elasticache/issues/21)) ([1135640](https://github.com/terraform-aws-modules/terraform-aws-elasticache/commit/1135640455df0ee16ef76bb5b0c6c3f069483b98))


### Bug Fixes

* Update CI workflow versions to latest ([#20](https://github.com/terraform-aws-modules/terraform-aws-elasticache/issues/20)) ([1bd81be](https://github.com/terraform-aws-modules/terraform-aws-elasticache/commit/1bd81beec317d4b05fc847c4e3b41bbbcc8460ea))

## [1.2.4](https://github.com/terraform-aws-modules/terraform-aws-elasticache/compare/v1.2.3...v1.2.4) (2024-10-01)


### Bug Fixes

* Correct output attribute mis-spelling ([#18](https://github.com/terraform-aws-modules/terraform-aws-elasticache/issues/18)) ([a4940aa](https://github.com/terraform-aws-modules/terraform-aws-elasticache/commit/a4940aa5d8d3f6f9427c050c57b4cda90bf09856))

## [1.2.3](https://github.com/terraform-aws-modules/terraform-aws-elasticache/compare/v1.2.2...v1.2.3) (2024-09-09)


### Bug Fixes

* Fix cache_usage_limits issue when empty map (default value) is provided. ([#13](https://github.com/terraform-aws-modules/terraform-aws-elasticache/issues/13)) ([2a02a2c](https://github.com/terraform-aws-modules/terraform-aws-elasticache/commit/2a02a2cf0fa4d62cee9a56f5be727b1bab7808cd))

## [1.2.2](https://github.com/terraform-aws-modules/terraform-aws-elasticache/compare/v1.2.1...v1.2.2) (2024-08-04)


### Bug Fixes

* Argument `replication_group_id` conflicts with `engine` and `log_delivery_configuration` ([#10](https://github.com/terraform-aws-modules/terraform-aws-elasticache/issues/10)) ([97bc4b5](https://github.com/terraform-aws-modules/terraform-aws-elasticache/commit/97bc4b5dbab8d2ea78ffd6aaf5716ab271f11f59))

## [1.2.1](https://github.com/terraform-aws-modules/terraform-aws-elasticache/compare/v1.2.0...v1.2.1) (2024-08-03)


### Bug Fixes

* Remove dots from inter_parameter_group_name ([#11](https://github.com/terraform-aws-modules/terraform-aws-elasticache/issues/11)) ([37286d0](https://github.com/terraform-aws-modules/terraform-aws-elasticache/commit/37286d0a1f8759008b0f9a46d337e6769bddb380))

## [1.2.0](https://github.com/terraform-aws-modules/terraform-aws-elasticache/compare/v1.1.0...v1.2.0) (2024-05-01)


### Features

* Support `transit_encryption_mode`  ([#4](https://github.com/terraform-aws-modules/terraform-aws-elasticache/issues/4)) ([d786a9e](https://github.com/terraform-aws-modules/terraform-aws-elasticache/commit/d786a9eb1fe76e42693dd8f54c458ebcf9127e84))

## [1.1.0](https://github.com/terraform-aws-modules/terraform-aws-elasticache/compare/v1.0.0...v1.1.0) (2024-04-24)


### Features

* Support elasticache serverless cache ([#3](https://github.com/terraform-aws-modules/terraform-aws-elasticache/issues/3)) ([f91028d](https://github.com/terraform-aws-modules/terraform-aws-elasticache/commit/f91028dc62cae00249ecc2709f06cb1be3a961de))
