# output "with_asg" {
#   value = local.wasg
# }

# output "without_asg" {
#   value = local.woasg
# }

output "ids" {
  value = data.terraform_remote_state.application_security_groups
}