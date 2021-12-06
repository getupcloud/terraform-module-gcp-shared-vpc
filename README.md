# Shared VPC Module

## Example

### terraform.tfvars:
```terraform
shared_vpcs = [
  {
    project_id      = "gcp-example-host-project-01"
    network_name    = "gcp-example-network-name-01"
    routing_mode    = "REGIONAL"
    shared_vpc_host = true

    subnets = [
      {
        subnet_name   = "gcp-example-subnet-name-01-a"
        subnet_ip     = "10.10.10.0/24"
        subnet_region = "us-west1"
      },
      {
        subnet_name           = "gcp-example-subnet-name-01-b"
        subnet_ip             = "10.10.20.0/24"
        subnet_region         = "us-east1"
        subnet_private_access = "true"
        subnet_flow_logs      = "true"
        description           = "This subnet has a description"
      },
      {
        subnet_name               = "gcp-example-subnet-name-01-c"
        subnet_ip                 = "10.10.30.0/24"
        subnet_region             = "us-west1"
        subnet_flow_logs          = "true"
        subnet_flow_logs_interval = "INTERVAL_10_MIN"
        subnet_flow_logs_sampling = 0.7
        subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
      }
    ]

    secondary_ranges = {
      subnet-01 = [
        {
          range_name    = "gcp-example-subnet-secondary-01"
          ip_cidr_range = "192.168.64.0/24"
        },
      ]

      subnet-02 = []
    }

    routes = [
      {
        name              = "egress-internet"
        description       = "route through IGW to access internet"
        destination_range = "0.0.0.0/0"
        tags              = "egress-inet"
        next_hop_internet = "true"
      }
    ]
  },
  {
    project_id      = "gcp-example-host-project-01"
    network_name    = "gcp-example-network-name-01"
    routing_mode    = "REGIONAL"
    shared_vpc_host = true

    subnets = [
      {
        subnet_name   = "gcp-example-subnet-name-02-a"
        subnet_ip     = "10.10.29.0/24"
        subnet_region = "us-west1"
      },
      {
        subnet_name           = "gcp-example-subnet-name-02-b"
        subnet_ip             = "10.10.39.0/24"
        subnet_region         = "us-west1"
        subnet_private_access = "true"
        subnet_flow_logs      = "true"
        description           = "This subnet has a description"
      },
      {
        subnet_name               = "gcp-example-subnet-name-02-c"
        subnet_ip                 = "10.10.49.0/24"
        subnet_region             = "us-east1"
        subnet_flow_logs          = "true"
        subnet_flow_logs_interval = "INTERVAL_10_MIN"
        subnet_flow_logs_sampling = 0.7
        subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
      }
    ]

    secondary_ranges = {
      subnet-01 = [
        {
          range_name    = "gcp-example-subnet-name-secondary-02"
          ip_cidr_range = "192.168.69.0/24"
        },
      ]

      subnet-02 = []
    }

    routes = [
      {
        name              = "egress-internet-2"
        description       = "route through IGW to access internet"
        destination_range = "0.0.0.0/0"
        tags              = "egress-inet"
        next_hop_internet = "true"
      }
    ]
  }
]

firewall_rules = [
  {
    project_id   = "gcp-example-host-project-01"
    network_name = "gcp-example-network-name-01"
    rules = [
      {
        name                    = "allow-ssh-ingress"
        description             = null
        direction               = "INGRESS"
        priority                = null
        ranges                  = ["0.0.0.0/0"]
        source_tags             = null
        source_service_accounts = null
        target_tags             = null
        target_service_accounts = null
        allow = [{
          protocol = "tcp"
          ports    = ["22"]
        }]
        deny = []
        log_config = {
          metadata = "INCLUDE_ALL_METADATA"
        }
      }
    ]
  },
  {
    project_id   = "gcp-example-host-project-02"
    network_name = "gcp-example-network-name-02"
    rules = [
      {
        name                    = "allow-ssh-ingress-2"
        description             = null
        direction               = "INGRESS"
        priority                = null
        ranges                  = ["0.0.0.0/0"]
        source_tags             = null
        source_service_accounts = null
        target_tags             = null
        target_service_accounts = null
        allow = [{
          protocol = "tcp"
          ports    = ["22"]
        }]
        deny = []
        log_config = {
          metadata = "INCLUDE_ALL_METADATA"
        }
      }
    ]
  }
]

service_vpcs = [
  {
    shared_unique_name = "gcp-example-service-project-01"
    host_subnet_users = {
      gcp-example-subnet-name-01-a = "serviceAccount:<ACCOUNT_NUMBER_ID>@cloudservices.gserviceaccount.com"
      gcp-example-subnet-name-01-b = "serviceAccount:<ACCOUNT_NUMBER_ID>@cloudservices.gserviceaccount.com"
    }
    service_project_ids = [
      "gcp-example-service-project-01"
    ]
    host_project_id = "gcp-example-host-project-01"
    host_subnets = [
      {
        name = "gcp-example-subnet-name-01-a",
        region = "us-west1"
      },
      {
        name = "gcp-example-subnet-name-01-b",
        region = "us-east1"
      }
    ]
  },
  {
    shared_unique_name = "gcp-example-service-project-02"
    host_subnet_users = {
      gcp-example-subnet-name-02-a = "serviceAccount:<ACCOUNT_NUMBER_ID>@cloudservices.gserviceaccount.com"
      gcp-example-subnet-name-02-b = "serviceAccount:<ACCOUNT_NUMBER_ID>@cloudservices.gserviceaccount.com"
    }
    service_project_ids = [
      "gcp-example-service-project-02"
    ]
    host_project_id = "gcp-example-host-project-02
    host_subnets = [
      {
        name = "gcp-example-subnet-name-02-a",
        region = "us-west1"
      },
      {
        name = "gcp-example-subnet-name-02-b",
        region = "us-east1"
      }
    ]
  }
]
```