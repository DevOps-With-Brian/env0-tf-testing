variable "env_tag" {
  type = string
  default = "dev"
  description = "What stage of development is this environment in?"
}

variable "service_name" {
  type = string
  default = "testing"
  description = "What is the name of the service?"
}