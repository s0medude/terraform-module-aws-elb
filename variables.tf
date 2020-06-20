variable "name" {
    description = "Name to be assigned on all resources as indentifier"
    type        = string
    default     = ""
}

variable "vpc_id" {
    description = "The Id of the vpc where to mount the reources"
    type        = string
    default     = ""  
}

variable "private_subnet_ids" {
  description = "A list of VPC Subnet IDs to launch in"
  type        = list(string)
  default     = []
}

variable "public_subnet_ids" {
  description = "A list of VPC Subnet IDs to launch the load balancer if its not internal type"
  type        = list(string)
  default     = []
}

variable "create_lb" {
    description = "Controls if a load blancer resource shoulb be created to traffic to the ec2 instance"
    type        = bool
    default     = false  
}

variable "internal" {
    description = "If true, the LB will be internal"
    type        = bool
    default     = false  
}

variable "load_balancer_type" {
    description = "The type of load balancer to create. Possible values are application or network. The default value is application."
    type        = string
    default     = ""  
}

variable "enable_deletion_protection" {
    description = "If true, deletion of the load balancer will be disabled via the AWS API. This will prevent Terraform from deleting the load balancer. Defaults to false."
    type        = bool
    default     = false
}

variable "enable_cross_zone_load_balancing" {
    description = "If true, cross-zone load balancing of the load balancer will be enabled. This is a network load balancer feature. Defaults to false."  
    type        = bool
    default     = false
}

variable "enable_http2" {
    description = "Indicates whether HTTP/2 is enabled in application load balancers. Defaults to true"
    type        = bool
    default     = true  
}

variable "idle_timeout" {
    description = "The time in seconds that the connection is allowed to be idle. Only valid for Load Balancers of type application. Default: 60."
    type        = number
    default     = 60  
}

variable "ip_address_type" {
    description = "The type of IP addresses used by the subnets for your load balancer. The possible values are ipv4 and dualstack"
    type        = string
    default     = "ipv4"  
}

variable "lb_tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}

variable "target_groups" {
  description = "A list of maps containing key/value pairs that define the target groups to be created. Order of these maps is important and the index of these are to be referenced in listener definitions. Required key/values: name, backend_protocol, backend_port. Optional key/values are in the target_groups_defaults variable."
  type        = any
  default     = []
}

variable "https_listeners" {
  description = "A list of maps describing the HTTPS listeners for this ALB. Required key/values: port, certificate_arn. Optional key/values: ssl_policy (defaults to ELBSecurityPolicy-2016-08), target_group_index (defaults to 0)"
  type        = list(map(string))
  default     = []
}

variable "http_tcp_listeners" {
  description = "A list of maps describing the HTTP listeners for this ALB. Required key/values: port, protocol. Optional key/values: target_group_index (defaults to 0)"
  type        = list(map(string))
  default     = []
}

variable "extra_ssl_certs" {
  description = "A list of maps describing any extra SSL certificates to apply to the HTTPS listeners. Required key/values: certificate_arn, https_listener_index (the index of the listener within https_listeners which the cert applies toward)."
  type        = list(map(string))
  default     = []
}

variable "instance_target_id" {
  description = "A list of the intances to attach with the target group"  
  type        = list(string)
  default     = []
}


variable "tags" {
  description = "A mapping of tags to assign to the resource"
  type        = map(string)
  default     = {}
}


variable "lb_depends_on" {
  description = "Dependecies of the Load Balancer to be created"
  type        = any
  default     = []
}
