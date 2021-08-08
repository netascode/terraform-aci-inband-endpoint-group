variable "name" {
  description = "Inband endpoint group name."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9_.-]{0,64}$", var.name))
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }
}

variable "vlan" {
  description = "Vlan ID. Minimum value: 1. Maximum value: 4096."
  type        = number

  validation {
    condition     = var.vlan >= 1 && var.vlan <= 4096
    error_message = "Minimum value: 1. Maximum value: 4096."
  }
}

variable "bridge_domain" {
  description = "Bridge domain name."
  type        = string

  validation {
    condition     = can(regex("^[a-zA-Z0-9_.-]{0,64}$", var.bridge_domain))
    error_message = "Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }
}

variable "contracts" {
  description = "Contracts."
  type = object({
    consumers          = optional(list(string))
    providers          = optional(list(string))
    imported_consumers = optional(list(string))
  })
  default = {}

  validation {
    condition = alltrue([
      for con in coalesce(var.contracts.consumers, []) : can(regex("^[a-zA-Z0-9_.-]{0,64}$", con))
    ])
    error_message = "`consumers`: Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }

  validation {
    condition = alltrue([
      for prov in coalesce(var.contracts.providers, []) : can(regex("^[a-zA-Z0-9_.-]{0,64}$", prov))
    ])
    error_message = "`providers`: Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }

  validation {
    condition = alltrue([
      for imp in coalesce(var.contracts.imported_consumers, []) : can(regex("^[a-zA-Z0-9_.-]{0,64}$", imp))
    ])
    error_message = "`imported_consumers`: Allowed characters: `a`-`z`, `A`-`Z`, `0`-`9`, `_`, `.`, `-`. Maximum characters: 64."
  }
}
