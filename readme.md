# Aurora MySQL Alarms
This module defines several alarms specific to Aurora MySQL. The intent is for this module to be included in database modules and stacks, abstracting away everything except the required parameters listed in the table below. Read [here](https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/Aurora.AuroraMonitoring.Metrics.html) for a thorough description of all Aurora metrics. 

Parameter name | Required? | Description
| --- | --- | ---
db_cluster_id   | Yes | The id of the cluster to monitor. This can be hard coded, or a reference to a cluster in the same stack.
db_instance_ids | Yes | (property of the cluster)
sns_topic_name  | Yes | The SNS topic to publish alarms. 
actions_enabled | No | Toggle to enable or disable actions associated with all alarms in this stack. 
aurora_volume_bytes_left_total_low_evaluation_periods | No | The number of periods that must be breached to alarm.
aurora_volume_bytes_left_total_low_threshold | No | The amount of storage left that will trigger alarm. 
create_aurora_volume_bytes_left_total_low | No | Toggle for creating this alarm. Useful if it needs to be excluded. 
create_db_instance_binary_log_size_high | No | Toggle for creating this alarm. Useful if it needs to be excluded. 
create_db_instance_connections_high | No | Toggle for creating this alarm. Useful if it needs to be excluded. 
create_db_instance_cpu_utilization_high | No | Toggle for creating this alarm. Useful if it needs to be excluded. 
create_db_instance_db_load_high | No | Toggle for creating this alarm. Useful if it needs to be excluded. 
create_db_instance_disk_queue_depth_high | No | Toggle for creating this alarm. Useful if it needs to be excluded. 
create_db_instance_engine_uptime_low | No | Toggle for creating this alarm. Useful if it needs to be excluded. 
create_db_instance_freeable_memory_low | No | Toggle for creating this alarm. Useful if it needs to be excluded. 
create_db_instance_load_non_cpu_utilization_high | No | Toggle for creating this alarm. Useful if it needs to be excluded. 
db_instance_binary_log_size_high_evaluation_periods | No | The number of periods that must be breached to alarm.
db_instance_binary_log_size_high_threshold | No | Size of the binary log that will trigger alarm.
db_instance_connections_high_evaluation_periods | No | The number of periods that must be breached to alarm.
db_instance_connections_high_threshold | No | Number of database connections that will trigger alarm.
db_instance_cpu_utilization_evaluation_periods | No | The number of periods that must be breached to alarm.
db_instance_cpu_utilization_threshold | No | CPU utilization threshold that will trigger alarm.
db_instance_db_load_high_evaluation_periods | No | The number of periods that must be breached to alarm.
db_instance_db_load_high_threshold | No | Database load threshold that will trigger alarm.
db_instance_disk_queue_depth_high_evaluation_periods | No | The number of periods that must be breached to alarm.
db_instance_disk_queue_depth_high_threshold | No | Disk queue depth threshold that will trigger alarm. 
db_instance_engine_uptime_low_evaluation_periods | No | The number of periods that must be breached to alarm.
db_instance_engine_uptime_low_threshold | No | Watches for instance restart. When this metric goes to 0, an instance restart has executed, and alarm will be triggered. This is useful as it replaces the functionality in RDS Events that notifies on instance restarts.
db_instance_freeable_memory_low_evaluation_periods | No | The number of periods that must be breached to alarm.
db_instance_freeable_memory_low_threshold | No | Value of freeable memory that will trigger alarm. 
db_instance_load_non_cpu_utilization_high_evaluation_periods | No | The number of periods that must be breached to alarm.
db_instance_load_non_cpu_utilization_high_threshold | No | CPU utilization threshold that will trigger alarm.
db_load_non_cpu_evaluation_periods | No | The number of periods that must be breached to alarm.
db_load_non_cpu_threshold | No | CPU utilization threshold that will trigger alarm.
tags | No | Tags to be applied to all alarms.

The alarms created are:


  - [instance-name]_db_instance_binary_log_size_high
  - [instance-name]_db_instance_connections_high
  - [instance-name]_db_instance_cpu_utilization_high
  - [instance-name]_db_instance_disk_queue_depth_high
  - [instance-name]_db_instance_freeable_memory_low
  - [instance-name]_db_instance_load_high
  - [instance-name]_db_instance_uptime_low
  - [cluster-name]_aurora_volume_bytes_left_total_low

# Example implementation

```
module "alarms" {
  source                                       = "truemark/rds-aurora-mysql-alarms/aws"
  version                                      = "0.0.1"
  db_cluster_id                                = module.db.cluster_id
  db_instance_ids                              = module.db.cluster_members
  sns_topic_name                               = "CenterGaugeAlerts"
  actions_enabled                              = false
  aurora_volume_bytes_left_total_low_threshold = 1000000000
  db_instance_cpu_utilization_threshold        = 95
}
```
# References
https://docs.aws.amazon.com/prescriptive-guidance/latest/amazon-rds-monitoring-alerting/db-instance-performance-insights.html

https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/USER_PerfInsights.UsingDashboard.AnalyzeDBLoad.AdditionalMetrics.MySQL.html#USER_PerfInsights.UsingDashboard.AnalyzeDBLoad.AdditionalMetrics.MySQL.per-secondv
https://docs.aws.amazon.com/AmazonRDS/latest/AuroraUserGuide/AuroraMySQL.BestPractices.html


# How to use tf-vars-sort.awk
```
cat variables.tf  |gawk -f ../postgres-rds/tf-vars-sort.awk  | tee sorted_variables.tf
cat outputs.tf  |gawk -f ../postgres-rds/tf-vars-sort.awk  | tee sorted_outputs.tf
```
