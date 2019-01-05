output "function_arn" {
  value = "${module.lambda.function_arn}"
}

output "function_name" {
  value = "${module.lambda.function_name}"
}

output "invoke_arn" {
  value = "${module.lambda.invoke_arn}"
}

output "role_id" {
  value = "${module.lambda.role_id}"
}

output "gateway_path" {
  value = "${var.gateway_path}"
}

output "gateway_method" {
  value = "${var.gateway_method}"
}
