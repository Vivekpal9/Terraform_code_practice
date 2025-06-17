

variable "resource_group_name"{}
  
variable "location"{}
  

  
variable "sql_server_name" {
  description = "The name of the SQL Server. It must be unique within the Azure region."
  type        = string
  
}