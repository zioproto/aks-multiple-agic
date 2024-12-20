variable "region" {
  type    = string
  default = "eastus"
}

variable "agents_size" {
  default     = "Standard_DS3_v2"
  description = "The default virtual machine size for the Kubernetes agents"
  type        = string
}

variable "kubernetes_version" {
  description = "Specify which Kubernetes release to use. The default used is the latest Kubernetes version available in the region"
  type        = string
  default     = null
}