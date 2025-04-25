variable "rds_engine" {
  description = "The database engine to use"
  type        = string
}

variable "rds_engine_version" {
  description = "The version of the database engine"
  type        = string
}

variable "rds_instance_class" {
  description = "The instance class for the RDS instance"
  type        = string
}

variable "rds_allocated_storage" {
  description = "The allocated storage for the RDS instance in GB"
  type        = number
}

variable "rds_max_allocated_storage" {
  description = "The maximum allocated storage for the RDS instance in GB"
  type        = number
}

variable "rds_name" {
  description = "The name of the database"
  type        = string
}

variable "rds_username" {
  description = "The master username for the RDS instance"
  type        = string
}

variable "rds_password" {
  description = "The master password for the RDS instance"
  type        = string
  sensitive   = true
}

variable "rds_port" {
  description = "The port for the RDS instance"
  type        = number
}

variable "rds_parameter_group_name" {
  description = "The name of the parameter group to associate with the RDS instance"
  type        = string
}

variable "rds_create_db_parameter_group" {
  description = "Whether to create a new DB parameter group"
  type        = bool
}

variable "rds_create_db_option_group" {
  description = "Whether to create a new DB option group"
  type        = bool
}

variable "rds_maintenance_window" {
  description = "The maintenance window for the RDS instance"
  type        = string
}

variable "rds_backup_window" {
  description = "The backup window for the RDS instance"
  type        = string
}

variable "rds_backup_retention_period" {
  description = "The backup retention period for the RDS instance"
  type        = number
}

variable "rds_skip_final_snapshot" {
  description = "Whether to skip the final snapshot when deleting the RDS instance"
  type        = bool
}

variable "subnet_rds" {
  description = "The subnet IDs for the RDS instance"
  type        = list(string)
}

variable "sec_group_rds" {
  description = "The security group IDs for the RDS instance"
  type        = list(string)
}

