# AWS Lambda + API Gateway Terraform Module

Terraform module to setup an AWS Lambda into API Gateway

## Usage

```tf
module "get-user-endpoint" {
  source                       = "assemble-inc/lambda/gateway"
  lambda_source_path           = "./bin/get-user-bin"
  lambda_handler               = "get-user"
  gateway_id                   = "gateway.id"
  gateway_parent_resource_id   = "gateway.resource.id"
  gateway_name                 = "api"
  gateway_path                 = "user"
  gateway_method               = "POST"
  region                       = "US_WEST_2"
  lambda_environment_variables = {
    "AWS_REGION": "US_WEST_2"
  }
}
```

## Inputs

- **region**: AWS Region
- **gateway_name**: Gateway name
- **gateway_path**: Gateway path
- **gateway_method**: Gateway method
- **gateway_id**: Gateway id
- **gateway_authorization**: Gateway authorization _(Default: NONE)_
- **gateway_parent_resource_id**: Gateway parent resource id (Usually: root_resource_id)
- **lambda_source_path**: Source Path
- **lambda_handler**: Lambda Handler
- **lambda_runtime**: Runtime _(Default: go1.x)_
- **lambda_timeout**: Timeout _(Default: 10)_
- **lambda_memory_size**: Memory size _(Default: 128)_
- **lambda_environment_variables**: Environment variables map
- **tags**: Tags map

## Outputs

- **function_arn**: Lambda function ARN
- **function_name**: Lambda function name
- **invoke_arn**: Lambda Invoke ARN
- **role_id**: Lambda Role ID
- **policy_arn**: Dynamo Policy ARN
- **gateway_path**: API Gateway Path
- **gateway_method**: API Gateway Method
