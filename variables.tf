variable "actions_enabled" {
  description = "Switch to enable actions (notifications). Default is true."
  type        = bool
  default     = true
}

variable "aurora_volume_bytes_left_total_low_evaluation_periods" {
  description = "The number of periods that must be breached to alarm."
  type        = number
  default     = 10
}

variable "aurora_volume_bytes_left_total_low_threshold" {
  description = "The amount of remaining space available on the Aurora volume."
  type        = number
  default     = 5000
}

variable "create_aurora_volume_bytes_left_total_low" {
  description = "Toggle to create aurora_volume_bytes_left_total_low alarm."
  type        = bool
  default     = true
}

variable "create_db_instance_binary_log_size_high" {
  description = "Toggle to create db_instance_binary_log_size_high alarm."
  type        = bool
  default     = true
}

variable "create_db_instance_connections_high" {
  description = "Toggle to create db_instance_connections_high alarm."
  type        = bool
  default     = true
}

variable "create_db_instance_cpu_utilization_high" {
  description = "Toggle to create db_instance_cpu_utilization_high alarm."
  type        = bool
  default     = true
}

variable "create_db_instance_db_load_high" {
  description = "Toggle to create db_instance_db_load_high alarm."
  type        = bool
  default     = true
}

variable "create_db_instance_disk_queue_depth_high" {
  description = "Toggle to create db_instance_disk_queue_depth_high alarm."
  type        = bool
  default     = true
}

variable "create_db_instance_engine_uptime_low" {
  description = "Toggle to create db_instance_engine_uptime_low alarm."
  type        = bool
  default     = true
}

variable "create_db_instance_freeable_memory_low" {
  description = "Toggle to create db_instance_freeable_memory_low alarm."
  type        = bool
  default     = true
}

variable "create_db_instance_load_non_cpu_utilization_high" {
  description = "Toggle to create db_instance_load_non_cpu_utilization_high alarm."
  type        = bool
  default     = true
}

variable "db_cluster_id" {
  description = "The cluster ID of the Aurora cluster that you want to monitor."
  type        = string
}

variable "db_instance_binary_log_size_high_evaluation_periods" {
  description = "The number of periods that must be breached to alarm."
  type        = number
  default     = 10
}

variable "db_instance_binary_log_size_high_threshold" {
  description = "The maximum file size allowed before transitioning to alarm."
  type        = number
  default     = 524288000
}

variable "db_instance_connections_high_evaluation_periods" {
  description = "The number of periods that must be breached to alarm."
  type        = number
  default     = 10
}

variable "db_instance_connections_high_threshold" {
  description = "The maximum number of database connections allowed before transitioning to alarm."
  type        = number
  default     = 500
}

variable "db_instance_cpu_utilization_evaluation_periods" {
  description = "The number of periods that must be breached to alarm."
  type        = number
  default     = 10
}

variable "db_instance_cpu_utilization_threshold" {
  description = "The maximum percentage of CPU utilization allowed before transitioning to alarm."
  type        = number
  default     = 90
}

variable "db_instance_db_load_high_evaluation_periods" {
  description = "The number of periods that must be breached to alarm."
  type        = number
  default     = 10
}

variable "db_instance_db_load_high_threshold" {
  description = "The maximum load allowed before transitioning to alarm."
  type        = number
  default     = 500
}

variable "db_instance_disk_queue_depth_high_evaluation_periods" {
  description = "The number of periods that must be breached to alarm."
  type        = number
  default     = 10
}

variable "db_instance_disk_queue_depth_high_threshold" {
  description = "The maximum percentage of CPU utilization allowed before transitioning to alarm."
  type        = number
  default     = 1000
}

variable "db_instance_engine_uptime_low_evaluation_periods" {
  description = "The number of periods that must be breached to alarm."
  type        = number
  default     = 1
}

variable "db_instance_engine_uptime_low_threshold" {
  description = "The minimum uptime allowed before transitioning to alarm."
  type        = number
  default     = 0
}

variable "db_instance_freeable_memory_low_evaluation_periods" {
  description = "The number of periods that must be breached to alarm."
  type        = number
  default     = 10
}

variable "db_instance_freeable_memory_low_threshold" {
  description = "The minimum freeable amount of memory allowed before transitioning to alarm."
  type        = number
  default     = 90
}

variable "db_instance_ids" {
  description = "The database instance ID of the Aurora instance that you want to monitor."
  type        = set(string)
}

variable "db_instance_load_non_cpu_utilization_high_evaluation_periods" {
  description = "The number of periods that must be breached to alarm."
  type        = number
  default     = 10
}

variable "db_instance_load_non_cpu_utilization_high_threshold" {
  description = "The maximum percentage of CPU utilization allowed before transitioning to alarm."
  type        = number
  default     = 90
}

variable "db_load_non_cpu_evaluation_periods" {
  description = "The number of periods that must be breached to alarm."
  type        = number
  default     = 10
}

variable "db_load_non_cpu_threshold" {
  description = "The percentage of non-database CPU utilization allowed before transitioning to alarm."
  type        = number
  default     = 90
}

variable "sns_topic_name" {
  description = "The name of the SNS topic to publish alerts to."
  type        = string
}

variable "tags" {
  description = "Tags to be added to all resources."
  type        = map(string)
  default     = {}
}
