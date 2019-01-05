variable "lambda_source_path" {
  type = "string"
}

variable "lambda_handler" {
  type = "string"
}

variable "lambda_runtime" {
  type    = "string"
  default = "go1.x"
}

variable "gateway_id" {
  type = "string"
}

variable "gateway_parent_resource_id" {
  type = "string"
}

variable "gateway_name" {
  type = "string"
}

variable "gateway_path" {
  type = "string"
}

variable "gateway_method" {
  type    = "string"
  default = "GET"
}

variable "gateway_authorization" {
  type    = "string"
  default = "NONE"
}

variable "gateway_api_key_required" {
  default = false
}

variable "lambda_timeout" {
  default = 10
}

variable "lambda_environment_variables" {
  type = "map"
}

variable "region" {
  type = "string"
}

variable "tags" {
  type = "map"
}
