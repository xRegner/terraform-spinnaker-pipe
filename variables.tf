### Variables that must be specified.



variable "spinnaker_url" {
  default = "http://localhost"
}




variable "spinnaker_cli_config" {
  description = "Path to the spin CLI config file where you can provide credentials for the API"
  default     = "./spin_config"
  validation {
    condition = (
      file(var.spinnaker_cli_config) != ""
    )
    error_message = "Please verify that the spin_config file path provided exists."
  }
}
