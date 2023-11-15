data "aws_caller_identity" "default" {}

data "aws_region" "current" {}

data "aws_kms_key" "shared" {
  key_id = "alias/shared"
}

#------------------------------------------------------------------------------
# This is the SNS topic all alerts go to.
data "aws_sns_topic" "alerts_notification_topic" {
  name = var.sns_topic_name
}

locals {
  account_id              = data.aws_caller_identity.default.account_id
  region_name             = data.aws_region.current.name
  customer_master_key_arn = data.aws_kms_key.shared.arn
  sns_topic_arn           = data.aws_sns_topic.alerts_notification_topic.arn
}

#------------------------------------------------------------------------------
# Define all alarms.
resource "aws_cloudwatch_metric_alarm" "db_instance_cpu_utilization_high" {
  for_each        = var.create_db_instance_cpu_utilization_high ? var.db_instance_ids : toset([])
  alarm_name      = "${each.key}_db_instance_cpu_utilization_high"
  actions_enabled = var.actions_enabled

  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = local.thresholds["DBInstanceCPUUtilizationEvaluationPeriods"]
  metric_name               = "CPUUtilization"
  namespace                 = "AWS/RDS"
  period                    = "60"
  statistic                 = "Maximum"
  threshold                 = local.thresholds["DBInstanceCPUUtilizationThreshold"]
  alarm_description         = "Instance CPU utilization is high, please investigate."
  alarm_actions             = [data.aws_sns_topic.alerts_notification_topic.arn]
  ok_actions                = [data.aws_sns_topic.alerts_notification_topic.arn]
  insufficient_data_actions = [data.aws_sns_topic.alerts_notification_topic.arn]
  treat_missing_data        = "breaching"
  tags                      = var.tags
  dimensions = {
    DBInstanceIdentifier = each.key
  }
}


resource "aws_cloudwatch_metric_alarm" "db_instance_load_high" {
  for_each        = var.create_db_instance_db_load_high ? var.db_instance_ids : toset([])
  alarm_name      = "${each.key}_db_instance_load_high"
  actions_enabled = var.actions_enabled

  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = local.thresholds["DBInstanceDBLoadHighEvaluationPeriods"]
  metric_name               = "DBLoad"
  namespace                 = "AWS/RDS"
  period                    = "60"
  statistic                 = "Maximum"
  threshold                 = local.thresholds["DBInstanceDBLoadHighThreshold"]
  alarm_description         = "The database load is high. Database performance may degrade."
  alarm_actions             = [data.aws_sns_topic.alerts_notification_topic.arn]
  ok_actions                = [data.aws_sns_topic.alerts_notification_topic.arn]
  insufficient_data_actions = [data.aws_sns_topic.alerts_notification_topic.arn]
  treat_missing_data        = "breaching"
  tags                      = var.tags
  dimensions = {
    DBInstanceIdentifier = each.key
  }
}

resource "aws_cloudwatch_metric_alarm" "aurora_volume_bytes_left_total_low" {
  count           = var.create_aurora_volume_bytes_left_total_low == true ? 1 : 0
  alarm_name      = "${var.db_cluster_id}_aurora_volume_bytes_left_total_low"
  actions_enabled = var.actions_enabled

  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = local.thresholds["AuroraVolumeBytesLeftTotalEvaluationPeriods"]
  metric_name               = "AuroraVolumeBytesLeftTotal"
  namespace                 = "AWS/RDS"
  period                    = "60"
  statistic                 = "Maximum"
  threshold                 = local.thresholds["AuroraVolumeBytesLeftTotalThreshold"]
  alarm_description         = "Aurora storage is nearing full. Investigate promptly."
  alarm_actions             = [data.aws_sns_topic.alerts_notification_topic.arn]
  ok_actions                = [data.aws_sns_topic.alerts_notification_topic.arn]
  insufficient_data_actions = [data.aws_sns_topic.alerts_notification_topic.arn]
  treat_missing_data        = "breaching"
  tags                      = var.tags
  dimensions = {
    DBClusterIdentifier = var.db_cluster_id
  }
}

resource "aws_cloudwatch_metric_alarm" "disk_queue_depth_high" {
  for_each        = var.create_db_instance_disk_queue_depth_high ? var.db_instance_ids : toset([])
  alarm_name      = "${each.key}_db_instance_disk_queue_depth_high"
  actions_enabled = var.actions_enabled

  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = local.thresholds["DiskQueueDepthEvaluationPeriods"]
  metric_name               = "DiskQueueDepth"
  namespace                 = "AWS/RDS"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = local.thresholds["DiskQueueDepthThreshold"]
  alarm_description         = "Average database disk queue depth high. i/o performance will suffer. Check db activity."
  alarm_actions             = [data.aws_sns_topic.alerts_notification_topic.arn]
  ok_actions                = [data.aws_sns_topic.alerts_notification_topic.arn]
  insufficient_data_actions = [data.aws_sns_topic.alerts_notification_topic.arn]
  treat_missing_data        = "breaching"
  tags                      = var.tags
  dimensions = {
    DBInstanceIdentifier = each.key
  }
}

resource "aws_cloudwatch_metric_alarm" "freeable_memory_low" {
  for_each        = var.create_db_instance_freeable_memory_low ? var.db_instance_ids : toset([])
  alarm_name      = "${each.key}_db_instance_freeable_memory_low"
  actions_enabled = var.actions_enabled

  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = local.thresholds["DBInstanceFreeableMemoryEvaluationPeriods"]
  metric_name               = "FreeableMemory"
  namespace                 = "AWS/RDS"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = local.thresholds["DBInstanceFreeableMemoryThreshold"]
  alarm_description         = "Average database instance freeable memory low. Performance will suffer, instance may crash."
  alarm_actions             = [data.aws_sns_topic.alerts_notification_topic.arn]
  ok_actions                = [data.aws_sns_topic.alerts_notification_topic.arn]
  insufficient_data_actions = [data.aws_sns_topic.alerts_notification_topic.arn]
  tags                      = var.tags
  treat_missing_data        = "breaching"
  dimensions = {
    DBInstanceIdentifier = each.key
  }
}

resource "aws_cloudwatch_metric_alarm" "db_connections_high" {
  for_each        = var.create_db_instance_connections_high ? var.db_instance_ids : toset([])
  alarm_name      = "${each.key}_db_instance_connections_high"
  actions_enabled = var.actions_enabled

  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = local.thresholds["DBInstanceConnectionsEvaluationPeriods"]
  metric_name               = "DatabaseConnections"
  namespace                 = "AWS/RDS"
  period                    = "60"
  statistic                 = "Maximum"
  threshold                 = local.thresholds["DBInstanceConnectionsThreshold"]
  alarm_description         = "The number of db connections is high. Check db instance activity."
  alarm_actions             = [data.aws_sns_topic.alerts_notification_topic.arn]
  ok_actions                = [data.aws_sns_topic.alerts_notification_topic.arn]
  insufficient_data_actions = [data.aws_sns_topic.alerts_notification_topic.arn]
  treat_missing_data        = "breaching"
  tags                      = var.tags
  dimensions = {
    DBInstanceIdentifier = each.key
  }
}

resource "aws_cloudwatch_metric_alarm" "binary_log_size" {
  for_each        = var.create_db_instance_binary_log_size_high ? var.db_instance_ids : toset([])
  alarm_name      = "${each.key}_db_instance_binary_log_size_high"
  actions_enabled = var.actions_enabled

  comparison_operator       = "GreaterThanThreshold"
  evaluation_periods        = local.thresholds["DBInstanceBinaryLogSizeHighEvaluationPeriods"]
  metric_name               = "SumBinaryLogSize"
  namespace                 = "AWS/RDS"
  period                    = "60"
  statistic                 = "Average"
  threshold                 = local.thresholds["DBInstanceBinaryLogSizeHighThreshold"]
  alarm_description         = "The binary log size is high. Check db instance activity and storage capacity."
  alarm_actions             = [data.aws_sns_topic.alerts_notification_topic.arn]
  ok_actions                = [data.aws_sns_topic.alerts_notification_topic.arn]
  insufficient_data_actions = [data.aws_sns_topic.alerts_notification_topic.arn]
  treat_missing_data        = "breaching"
  tags                      = var.tags
  dimensions = {
    DBInstanceIdentifier = each.key
  }
}

resource "aws_cloudwatch_metric_alarm" "db_instance_engine_uptime_low" {
  for_each        = var.create_db_instance_engine_uptime_low ? var.db_instance_ids : toset([])
  alarm_name      = "${each.key}_db_instance_uptime_low"
  actions_enabled = var.actions_enabled

  comparison_operator       = "LessThanThreshold"
  evaluation_periods        = 1
  metric_name               = "EngineUptime"
  namespace                 = "AWS/RDS"
  period                    = "60"
  statistic                 = "Minimum"
  threshold                 = 10
  alarm_description         = "Database instance has restarted."
  alarm_actions             = [data.aws_sns_topic.alerts_notification_topic.arn]
  ok_actions                = [data.aws_sns_topic.alerts_notification_topic.arn]
  insufficient_data_actions = [data.aws_sns_topic.alerts_notification_topic.arn]
  treat_missing_data        = "breaching"
  tags                      = var.tags
  dimensions = {
    DBInstanceIdentifier = each.key
  }
}
