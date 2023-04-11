# Define a variable so we can pass in our token
variable "doppler_token" {
  type = string
  description = "A token to authenticate with Doppler"
}

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

variable "az_location" {
  type = string
  default = "azeastus2"
  description = "What location should it be deployed?"
}