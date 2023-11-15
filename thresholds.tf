locals {
  thresholds = {
    AuroraVolumeBytesLeftTotalEvaluationPeriods  = min(max(var.aurora_volume_bytes_left_total_low_evaluation_periods, 1), 100)
    AuroraVolumeBytesLeftTotalThreshold          = min(max(var.aurora_volume_bytes_left_total_low_threshold, 1), 1000000000000) # 1TB
    DBInstanceBinaryLogSizeHighEvaluationPeriods = min(max(var.db_instance_binary_log_size_high_evaluation_periods, 1), 10)
    DBInstanceBinaryLogSizeHighThreshold         = min(max(var.db_instance_binary_log_size_high_threshold, 1), 5242880000)
    DBInstanceConnectionsEvaluationPeriods       = min(max(var.db_instance_connections_high_evaluation_periods, 1), 10)
    DBInstanceConnectionsThreshold               = min(max(var.db_instance_connections_high_threshold, 1), 10000)
    DBInstanceCPUUtilizationEvaluationPeriods    = min(max(var.db_instance_cpu_utilization_evaluation_periods, 1), 10)
    DBInstanceCPUUtilizationThreshold            = min(max(var.db_instance_cpu_utilization_threshold, 1), 100)
    DBInstanceDBLoadHighEvaluationPeriods        = min(max(var.db_instance_db_load_high_evaluation_periods, 1), 10)
    DBInstanceDBLoadHighThreshold                = min(max(var.db_instance_db_load_high_threshold, 1), 100)
    DBInstanceFreeableMemoryEvaluationPeriods    = min(max(var.db_instance_freeable_memory_low_evaluation_periods, 1), 10)
    DBInstanceFreeableMemoryThreshold            = min(max(var.db_instance_freeable_memory_low_threshold, 1), 100)
    DiskQueueDepthEvaluationPeriods              = min(max(var.db_instance_disk_queue_depth_high_evaluation_periods, 1), 10)
    DiskQueueDepthThreshold                      = min(max(var.db_instance_disk_queue_depth_high_threshold, 1), 1000)
  }
}
