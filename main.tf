module "vpc" {
  source = "terraform-google-modules/network/google"
  version = "~> 4.0.1"
  for_each = {
    for vpc in var.shared_vpcs : "${vpc.project_id}-${vpc.network_name}" => merge({
      routing_mode = var.default_routing_mode
      },
      vpc
    )
  }

  project_id      = each.value.project_id
  network_name    = each.value.network_name
  subnets         = each.value.subnets
  routes          = each.value.routes
  routing_mode    = each.value.routing_mode
  shared_vpc_host = each.value.shared_vpc_host

}

module "firewall_rules" {
  source = "terraform-google-modules/network/google//modules/firewall-rules"
  version = "~> 4.0.1"
  for_each = {
    for fr in var.firewall_rules : "${fr.project_id}-${fr.network_name}" => fr
  }
  project_id   = each.value.project_id
  network_name = each.value.network_name
  rules        = each.value.rules
  depends_on   = [ module.vpc ]
}

module "net-shared-vpc-access" {
  source              = "terraform-google-modules/network/google//modules/fabric-net-svpc-access"
  version            = "~> 4.0.1"
  for_each = {
    for vpc in var.service_vpcs : vpc.shared_unique_name => vpc
  }
  host_project_id     = each.value.host_project_id
  service_project_ids = each.value.service_project_ids
  host_subnets        = [ for s in each.value.host_subnets : s.name ]
  host_subnet_regions = [ for r in each.value.host_subnets : r.region ]
  host_service_agent_role = false
  host_subnet_users = each.value.host_subnet_users
  depends_on = [ module.vpc, module.firewall_rules ]
}