module "global_accelerator" {
  source = "terraform-aws-modules/global-accelerator/aws"

  name = var.name

  flow_logs_enabled   = true
  flow_logs_s3_bucket = "${var.name}-flow-logs"
  flow_logs_s3_prefix = var.name

  listeners = {
    main = {
      endpoint_group = {
        health_check_port             = 80
        health_check_protocol         = "HTTP"
        health_check_path             = "/"
        health_check_interval_seconds = 10
        health_check_timeout_seconds  = 5
        healthy_threshold_count       = 2
        unhealthy_threshold_count     = 2
        traffic_dial_percentage       = 100

        endpoint_configuration = [{
          client_ip_preservation_enabled = true
          endpoint_id                    = var.alb_arn_eu_west_1
        }]
      }
      endpoint_group = {
        health_check_port             = 80
        health_check_protocol         = "HTTP"
        health_check_path             = "/"
        health_check_interval_seconds = 10
        health_check_timeout_seconds  = 5
        healthy_threshold_count       = 2
        unhealthy_threshold_count     = 2
        traffic_dial_percentage       = 0 # Incase of regional failover only

        endpoint_configuration = [{
          client_ip_preservation_enabled = true
          endpoint_id                    = var.alb_arn_us_east_1
        }]
      }

      port_ranges = [
        {
          from_port = 80
          to_port   = 80
        }
      ]
      protocol = "TCP"
    }
  }

  tags = {
    Environment = var.environment
  }
}


