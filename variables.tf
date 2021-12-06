variable "shared_vpcs" {
  type    = list(any)
  default = []
}

variable "default_routing_mode" {
  description = "Routing mode of the VPC network"
  type        = string
  default     = "REGIONAL"
}

variable "firewall_rules" {
  description = ""
  type        = list(any)
}

variable service_vpcs {
  description = "VPCs to be used for services"
  type        = list(any)
  default     = []
}