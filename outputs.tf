output "lb_id" {
    description = "The id of the load balancer"
    value       = concat(aws_lb.master.*.id, [""])[0]
}

output "lb_arn" {
    description = "The id of the load balancer"
    value       = concat(aws_lb.master.*.arn, [""])[0]
}

output "lb_arn_suffix" {
    description = "The id of the load balancer"
    value       = concat(aws_lb.master.*.arn_suffix, [""])[0]
}

output "lb_dns_name" {
    description = "The id of the load balancer"
    value       = concat(aws_lb.master.*.dns_name, [""])[0]
}

output "lb_zone_id" {
    description = "The id of the load balancer"
    value       = concat(aws_lb.master.*.zone_id, [""])[0]
}